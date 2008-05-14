mailboxes imaps://scalix.sourcefire.com

set imap_user='wechlin'
set folder="imaps://scalix.sourcefire.com/"
set spoolfile="imaps://scalix.sourcefire.com/inbox"
set hostname="gauss.sfeng.sourcefire.com"
set from="Liam Echlin <wechlin@sourcefire.com>"

set postponed=+postponed
set record=+outbox

lists homeoffice firemen
subscribe homeoffice firemen

folder-hook License\ Keys 'set sort=subject'

save-hook '~s \\[Bug' =Bugs/

source ~/.muttrc
