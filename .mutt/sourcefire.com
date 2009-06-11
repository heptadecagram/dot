set imap_user='wechlin@sourcefire.com'
set folder="imaps://imap.gmail.com:993"
set spoolfile="+INBOX"
set hostname="gauss.sfeng.sourcefire.com"
set from="Liam Echlin <wechlin@sourcefire.com>"

set postponed="+[Gmail]/Drafts"

source ~/.muttrc

folder-hook License\ Keys 'set sort=subject'

save-hook '~s \\[Bug' =Bugs/

