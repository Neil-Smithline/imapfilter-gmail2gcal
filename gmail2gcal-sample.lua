------------------------------------------------------------------------
-- Gmail2Gcal configuration example for IMAPFilter
--
-- 1) Insert the coontents of this file at the end of your
-- 'config.lua' file.
--
-- 2) Change the line, near the end of the code, so that the call to
-- 'dofile' contains the correct path to your copy of the gmail2gcal
-- shell script.
------------------------------------------------------------------------

-- It is probably best to put this line near the top of your
-- 'config.lua' file.
dofile 'gmail-account.lua'

function do_subject(msgs, cmd)
  count = 0
  result = Set()
  for _, mesg in ipairs(msgs) do
    count = count + 1
    -- mbox, uid = table.unpack(mesg)
    mbox = mesg[1]
    uid = mesg[2]
    print("uid=" .. uid .. ".")
    subject = mbox[uid]:fetch_field("Subject")
    if cmd == nil then
      print("    NO COMMAND")
    else
      pipe_to(cmd, subject)
    end
  end
  return count
end


gmail2gcal=gmail._Gmail2Gcal:select_all()
------------------------------------------------------------------------
-- Modify this line to have the correct path.
do_subject(gmail2gcal, "REPLACE-WITH-APPROPRIATE-PATH/gmail2gcal `cat`")
------------------------------------------------------------------------
gmail._Gmail2Gcal:delete_messages(gmail2gcal)


------------------------------------------------------------------------
-- Gmail2Gcal for IMAPFilter by Neil Smithline is licensed under a
-- Creative Commons Attribution-ShareAlike 3.0 Unported License.
--
-- See https://github.com/Neil-Smithline/imapfilter-gmail2gcal for
-- more details.
------------------------------------------------------------------------
