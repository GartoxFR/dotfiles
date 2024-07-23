return {
    "kmonad/kmonad-vim",
    "jalvesaq/Nvim-R",
    "jrozner/vim-antlr",
    {
        "nvim-orgmode/orgmode",
        opts = {
            org_agenda_files = {'~/org/**/*'},
            org_default_notes_file = '~/org/refile.org',
            org_capture_templates = {
                t = {
                    description = 'Simple task',
                    template = '* TODO %?\n %u'
                },
                f = {
                    description = 'Task in file',
                    template = '* TODO %a %?\n %u'
                },
                e =  'Event',
                er = {
                    description = 'recurring',
                    template = '** %?\n',
                    target = '~/org/calendar.org',
                    headline = 'recurring'
                },
                eo = {
                    description = 'one-time',
                    template = '** %?\n',
                    target = '~/org/calendar.org',
                    headline = 'one-time'
                }
            }
        }
    },
}
