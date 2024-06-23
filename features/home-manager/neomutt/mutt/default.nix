{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [ html2text lynx urlscan ];
  programs.neomutt = {
    enable = true;
    extraConfig = ''
      # vim: filetype=neomuttrc
#     set mailcap_path = $HOME/.config/mutt/mailcap
#     set rfc2047_parameters = yes
#     set check_mbox_size = yes

      #### General Key Bindings
      source $HOME/.config/mutt/keys/unbinds.muttrc 
      source $HOME/.config/mutt/keys/binds.muttrc 

      #### General Settings
      set smtp_authenticators = 'gssapi:login'
      unset help
      set sleep_time = 0		        # Pause 0 seconds for informational messages
      set pager_read_delay = 3      # View a message for 3 seconds to mark as read
      set mark_old = no		          # Unread mail stay unread until read
      set mime_forward = no	  	    # attachments are forwarded with mail
      set wait_key = no		          # mutt won't ask "press key to continue"
      set fast_reply			          # skip to compose when replying
      set fcc_attach			          # save attachments with the body
      set forward_format = "FW: %s" # format of subject when forwarding
      set forward_quote		          # quote forwarded message
      set reverse_name	            # reply as whomever it was to
      set reverse_realname=yes      # use any real name provided when replying
      set auto_tag                  # automatically apply commands to all tagged messages (if some messages are tagged)
      set include			              # include message in replies
      set mail_check=5              # to avoid lags using IMAP with some email providers (yahoo for example)
      set timeout=5                 # how long to wait after user input until unblocking background stuff like mail syncing
      set count_alternatives=yes    # recurse into text/multipart when looking for attachement types
      set thorough_search=no        # don't process mail (via mailcap etc) before parsing with queries like ~B 
      set flag_safe                 # flagged messages can't be deleted

      #### Colors, Symbols and Formatting
      source ~/.config/mutt/styles.muttrc

      #### Header Options
      ignore *                                # ignore all headers
      unignore to: cc:                        # ..then selectively show only these headers
      unhdr_order *                           # some distros order things by default
      hdr_order from: to: cc: date: subject:  # header item ordering

      #### View Settings
      set allow_ansi             # allow ansi escape codes (e.g. colors)
      set pager_index_lines = 10 # number of index lines to show
      set pager_context = 3      # number of context lines to show
      set pager_stop             # don't go to next message automatically
      set menu_scroll            # scroll in menus
      set smart_wrap             # wrap lines at word boundaries rather than splitting up words
      set wrap=90                # email view width
      set quote_regexp = "^( {0,4}[>|:#%]| {0,4}[a-z0-9]+[>|]+)+"
      set reply_regexp = "^(([Rr][Ee]?(\[[0-9]+\])?: *)?(\[[^]]+\] *)?)*"
      # Tidy up emails significantly
      set display_filter="perl -0777pe 's/___{10,}[^_]*microsoft teams meeting.*to join the meeting<([^>]*).*(___{10,})/\\n────────────────────────────────────────────────────────────────────────\\n\\nTeams Meeting ~~\\n\\nMeeting URL:\\n$1\\n\\n────────────────────────────────────────────────────────────────────────/is'| sed 's/^\\(To\\|CC\\): \\([^<]*[^>]\\)$/\\1\:<\\2>/g' | perl -0777pe 's/(((?!.*CC:)To:|CC:).+?(?=>\\n)>)/$1!REMOVE_ME!\\n!END!/gs' | sed '/^To:/{;:l N;/!END!/b; s/\\(\\n\\|  *\\|\\t\\t*\\)/ /g; bl}' | sed '/^To:/,/>$/ s/\\([^>]*>,\\?\\)/\\1\\n/g' | sed -e 's/^ \\(CC:\\)\\(.*$\\)/\\1\\n\\2/' -e 's/^\\(To:\\)\\(.*$\\)/\\1 --------------------------------------------------------------------\\n\\2/' -e 's/^!END!$/------------------------------------------------------------------------/' -e '/!REMOVE_ME!/d' -e '/\\[-- Type: text.* --\\]/d' -e '/\\[-- Autoview.* --\\]/d' -e '/\\[-- Type.* --\\]/d' -e '/\\[-- .*unsupported.* --\\]/d' -e '/\\[-- Attachment #[0-9] --\\]/d' -e 's/Attachment #[0-9]: //g' -e '/./,/^$/!d' -e 's/\\([A-Z]*\\), *\\([A-Za-z]*\\)\\(\"\\)\\?/\\2 \\L\\u\\1\\E\\3/g'"

#     #### Notmuch Config
#     set nm_query_type=threads                                   # bring in the whole thread instead of just the matched message, really useful
#     set nm_record_tags = "sent"                                 # default 'sent' tag
#     set virtual_spoolfile=yes                                   # allow using virtual mailboxes as spoolfile 
      macro index \Cg "<enter-command>unset wait_key<enter><shell-escape>read -p 'Enter a search: ' x; echo \$x >~/.cache/mutt_terms<enter><change-folder>All Accounts<enter><limit>~i \"\`notmuch --config ~/.config/notmuch/notmuchrc search --output=messages \$(/bin/cat ~/.cache/mutt_terms) | head -n 1000 | perl -le '@a=<>;chomp@a;s/\^id:// for@a;$,=\"|\";print@a' | sed 's/id://g' \`\"<enter>" "Search all mailboxes in all accounts (Global search)"

      #### Content/Autoview
      auto_view application/ics
      auto_view text/calendar
      auto_view text/plain
      auto_view text/html
      auto_view application/pgp-encrypted
      alternative_order text/calendar application/ics text/plain text/enriched text/html

      #### Sidebar Config
      set sidebar_divider_char = ' 	░'
      set sidebar_folder_indent = yes
      set sidebar_indent_string = ' - '
      set sidebar_non_empty_mailbox_only = yes
      set sidebar_visible = no
      set sidebar_width   = 50
      set sidebar_next_new_wrap = yes
      set sidebar_short_path = yes
      set sidebar_component_depth = 0

      #### Thread ordering
      set use_threads=reverse
      set sort='last-date'
      set collapse_all = yes
      set uncollapse_new = no
      set thread_received = yes
      set narrow_tree=no

      #### Lists
      set auto_subscribe

      ### Sounds
      set beep=no  # don't beep for errors
      set beep_new # beep for new messages

      #### Text editor
      set editor="mutt-trim %s; nvim +':set textwidth=72' +':set wrapmargin=0' +':set wrap' +':set spell' %s"

      #### Markdown to html email conversion
      macro compose M "F pandoc -s -f markdown -t html \ny^T^Utext/html; charset=UTF-8\n" "Convert from MD to HTML"

      #### Show patch files (requires git-split-diffs)
      macro attach P "|git-split-diffs --color | less -RF<enter>" "View a patch file as a diff"
      set wait_key=no

      # this is a bit of a hack which you may not want/need
      timeout-hook 'exec sync-mailbox' # sync mailbox whenever idle
    '';
  };
  xdg = {
    configFile."mutt/styles.muttrc".source = ./styles.muttrc;
    configFile."mutt/mailcap".source = ./mailcap;
    configFile."mutt/keys/" = {
      source = ./keys;
      recursive = true;
    };
  };
  home.persistence = lib.mkIf config.optinpermanence.enable {
    "/persist/home/${config.home.username}/mail" = {
      directories = [ ".cache/neomutt" ];
    };
  };
}
