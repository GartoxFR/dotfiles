import XMonad
import XMonad.Actions.Warp (warpToScreen)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops 
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks)
import XMonad.Layout.Accordion (Accordion (Accordion))
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile (ResizableTall (ResizableTall))
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.WindowNavigation
import XMonad.StackSet qualified as W
import XMonad.Util.Cursor (setDefaultCursor)
import XMonad.Util.EZConfig
import XMonad.Util.Run (hPutStrLn, spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.Ungrab
import XMonad.Prelude

myKeys =
  [ ("M-p", spawn "rofi -show drun -show-icons"),
    ("M-<Return>", spawn "alacritty"),
    ("M-S-m", windows W.swapMaster),
    ("M-<Pause>", spawn "rofi -show p -modi p:/home/ewan/dotfiles/rofi/bin/power-menu"),
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%"),
    ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%"),
    ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    ("<XF86AudioMicMute>", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
  ]
    ++ [ ("M-" ++ mod ++ k, (screenWorkspace sc >>= flip whenJust x) <+> xWarp sc)
         | (k, sc) <- zip ["w", "e"] [1, 0],
           (x, mod) <- [(xView, ""), (xShift <+> xView, "S-")]
       ]
  where
    xView = windows . W.view
    xShift = windows . W.shift
    xWarp i = warpToScreen i 0.5 0.5

main :: IO ()
main = do
  xmproc0 <- spawnPipe "xmobar -x 0"
  xmproc1 <- spawnPipe "xmobar -x 1"
  xmonad . ewmhFullscreen . ewmh . docks $
    def
      { terminal = "alacritty",
        modMask = mod4Mask,
        startupHook = myStartupHook,
        logHook =
          dynamicLogWithPP
            myBarFormat
              { ppOutput = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x
              },
        manageHook = myManageHook <+> manageDocks <+> manageHook def,
        layoutHook = myLayoutHook,
        focusedBorderColor = "#A6E3A1",
        normalBorderColor = "#000000",
        borderWidth = 2
      }
      `additionalKeysP` myKeys

myStartupHook :: X ()
myStartupHook = do
  setDefaultCursor xC_left_ptr
  spawn "nitrogen --restore"

myManageHook :: ManageHook
myManageHook = composeAll 
    [ className =? "leagueclientux.exe" --> doFloat ]

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

tall =
  renamed [Replace "tall"] $
    limitWindows 5 $
      smartBorders $
        windowNavigation $
          mySpacing 8 $
            ResizableTall 1 (3 / 300) (1 / 2) []

full =
  renamed [Replace "full"] $
    smartBorders $
      windowNavigation Full

accordion = Accordion

myLayoutHook = avoidStruts layouts
  where
    layouts = tall ||| full ||| accordion

myBarFormat :: PP
myBarFormat =
  def
    { ppOrder = \[ws, _, _, s, w] -> [ws, s, w],
      ppCurrent = wrap "<box type=Bottom mb=3 width=3 color=#A6E3A1> " " </box>",
      ppVisible = wrap "<box type=Bottom mb=3 width=3 color=#3E3E3E> " " </box>",
      ppSep = " | ",
      ppExtras = [focusedScreen, windowCount],
      ppHidden = wrap " " " "
    }

formatScreenPP :: String -> String
formatScreenPP = wrap "<fc=#A6E3A1>" "</fc>"

focusedScreenMsg :: ScreenId -> String
focusedScreenMsg (S 0) = "Primary"
focusedScreenMsg (S id) = "Secondary"

focusedScreen :: X (Maybe String)
focusedScreen = withWindowSet $ return . return . formatScreenPP . focusedScreenMsg . W.screen . W.current

windowCountPP :: Int -> String
windowCountPP i = tag $ "Entropy: " ++ show i
  where
    tag = wrap ("<fc=" ++ color ++ ">") "</fc>"
    color
      | i < 5 = "#3E3E3E"
      | i < 10 = "#F9E2AF"
      | otherwise = "#F38BA8"

windowCount :: X (Maybe String)
windowCount = withWindowSet $ return . return . windowCountPP . length . W.allWindows
