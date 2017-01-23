#This script changes the Plasma Kickoff launcher icon to doom guy's face based on load average. For the load average number I removed the decimal so 0.10=10, 0.60=60, 1.03=103 and so on. I am grabbing the load average from 'uptime' and taking the 5 min load average, this can be changed to the 1 min load average or the 15 min average by changing the delimited field displayed by cut on line 34. The values are set rather low to begin with mostly because I wanted to see the face change often :). They should be tweaked for your system. The polling interval is set to 10 seconds but can be changed on line 30.

#Check if dir exists if not make it and make images
if [ ! -d "$HOME/doomguy" ]
then

#Create dir
mkdir ~/doomguy

#Move to doomguy dir
cd ~/doomguy

#Make doom guy image in doomguy folder in home dir from base64 encoded versions
echo "iVBORw0KGgoAAAANSUhEUgAAABgAAAAeCAYAAAA2Lt7lAAAC20lEQVR42sWWoXcTQRCH7z9AVCAQiApEREVERURERURFRUREREUE4gSiAhFRUYFAICoqIhAnEJWREZUIBLICgUQgkMgl3ybfMuUuDQ9D3pu3e7Mzv9/s7Oxsqup//E6Pn6Xzk8Mi9ehFen3Wawl6bfDZC9zvHWTj8fB5uhwfpXfnx+n21Um6m5+mz1fjInyjX8wGmUgfRjAeBcchAn+6PCugy4tRBlWwQ9wRJOykkwQlRm8m/UICCKDoIETX1MNWqtwBGEjv8MlDAhTDo6dlB4wSGKVChIzm3VHgKC0CDM0lIMwh4TARdIzYORoYGO4AXYsAYyTmUxKrKBIppA+JhIydBICZf0nIedTz7WEzj2SS7CQwNRwoIAAI2CVx3SKwkjoJiJLIKEvKExEIgCgCa4cPvh76XoIfzUX6tqjLHYjpYO7lwwZbCcB4lICocEqr6yzMJbp/O80i8J92+LYIUHo4sVI84K/Xs+Jo7p2zZhHoJwFzbArBqP/7gMkj5aZYfqYo6hR8PGiwCoHl9XLcL9HVdc328jgYDPKcKE0Rc9cdl8tl2RlY3pfKlstlYdFdfL+5SavJpLRk9ObeVsEaNtgavb3L9coPxi/zeY7QdiwZZYg+NWtZbmzQRRt80IMRMSujMUIOjrJjBCSDbqtEglI9zYYo+oARMXMlyeaFMpoM+PFDdszfa/B0v8pzdKxhE3cNhjso98A2bX/BmIh+3m7S4ev1/mqWhTk61rDB1ssYX7kHb4IVgEGOdpsWHG12dk4bIWumCx8fKNZbLxqM5BMjnIjMN9gU2NxMoevY4oMvGK3o+RGROcQ5tgcA0t0i5z3nfj03fZYuc89we0/aP99ey9J3YTE96BTfiFi2uTR3/XzFYhuWrJRpMy0RRxsv6c7o/XH7iMQ7ES8U/5Xi/yXvALZ855v7N78uEsQW7fc/gcd02Z9KitaHi5gi+87etOzbja9YFLvwPv9fSzQKXI32KAUAAAAASUVORK5CYII=" | base64 -d > 1.png

echo "iVBORw0KGgoAAAANSUhEUgAAABgAAAAfCAYAAAD9cg1AAAAC5klEQVR42sWWIXdaQRBG3z+oiKioQCAqEAhEBAIRgYhAICoQEYiKJyoiKhARiIiIiogKRAWiIvLJiMqKisqIisrKyspt7sDdLAFCT004Z87u2535vpnZ2Vmq6jl+p8ev0tlJO0s9fJ3ejzpbwro62BwE7nWOQnk8aKWLcTct60Fqzofpy+w0fbsYpe/zcQjfN+9O0mLaDyJtGMF4EhyDD2fHYVwCS8a6gh5iRJAQyU4SFlG6fNPbIAGUNTxmDaLHqTICMJBO+8UmAQuD7sscASNgGAlMvhnxUF3PSq/BKWWLAEVzyYgQBd/so8c3ehCWZOwZgbobBCgjpglwowCsTAH7pMqI3JeQcScBSuaf1PDNQRuJxJAAKonpk2QvgbkH3MMFRDDJGF1DyiKQZCcB3ls5iiSMliU6el/qeV4HCaj738vz9GtR54sloKXKGnvooMvci/ckAd5glG6vQ5hLdHc1CRH4sR62WwQsWnL2F4ScAoSxhqbDOXvooKudBMzRyQTD3sMBW/eK5efNLdcUbDxosDKBZfZ23Mve1XVNeDH2+/2YUx2miLn7jk3T5MjAsnQrWy5VYAosU8ktX3PP3DZuJWljRblf+cH4YzYLD23HpoyOynpa3kuz0mGt1MGGdTBKzEpv9PDn9TTKjhGQAF1XiQS5epYrotIGjBIzKkk26htvkAeP52EY3/fg6e425qylr59Dh2+jQYwg3wPbtI8I4eLRn5tZNmbv03wawlwn0EEXG2+zLX/jTbACIAhv12khKpsgAMhVe9XO2TNd2Hjg6G69aDCSTwAwwjOUvcG2C2TeauUbjQ66VhcYW97z8/UCAOOyPUhI3pFmNIq1sm0w9wz3/quw7VqWPuiLydGGfOx2Y/TtKMs2SnPfz1eMsDFwNIqoquUke1zqeH7rW77/VzY670L58Ht7jdTat+H90z+7XSSILdrv/wIv02V/8mJR795Y1uw7B9NyKBpfsVJMWfXcv78XQffRaNA82gAAAABJRU5ErkJggg==" | base64 -d > 2.png

echo "iVBORw0KGgoAAAANSUhEUgAAABkAAAAfCAYAAAASsGZ+AAADDUlEQVR42sWWLXcTQRSG+w8QCERERAQiIqKiAhFREVGxIiICURGBWIGoQERERCAqEBWIyApEBSKyorKiAolEIpHIIc+0z5ybZncJijnnnpmd+/HeuR8ze3T0v8bZSS+dnw4y1ZPX6UM1bCR4yqFzkPHj4cusMB33s5GPs+N08/400+Zikon1ev4mfTo/2QFChxkbnQAIooRxjFzX43S3OEsPyyoTaygCIRtPxolagWAgEAHwHOPfL99m+raaFkCAkEFWMEGGgxf7IGx6EoQhAPAWYxh3Zh/j8gSJJ8HeHpCbAMVcoIwxjLsniIbhM1sA2IBaQSAEVcYQp8M4Xi6noxJKE24lMnuKVhA9QNBKAYg1M7zx6FV2ACBADA/78RSdIBhEyZDx7WkERE4AwdBhho+txuQLEnsEA4SJb8pWIMENn/mxaQ1dI4je6KFJxqg5sG8Edg+y9P8KYpjw2A6PQBoyhJ5COSttDwTmdiogCFq2v64v0s91ndd4HpvPU8FDBtkIgs0n248gVAcMvUIp3V490mZVgAyNhuEpxze62LDiCgibEYQw8G04flzNsxEUMP77ZpHX7MFDJuqYF75ZZ5B4Xct0hodBy9STWCTyok60BS+DkMzIIGGbqsoxhZa9XskZntpLkZfjv9XxxtAmcwmXG8aU8l0s5+ldXZXrg9m3Je4hg6x3ndUIv4SLIYhXOmQlxVuYfEBxz0qLujblTp94KSLsO4FwuluXSosVt7O3ldEpdRtBGF4lEPWPEZXhZdD7L5n0tjizlUUnvi2NL6NKNBSKhMWQWVV4DrG+HAwKD1l00NWpRhCOx7OKYjRG7O0Hr4+vk0la9fulQZVHFxuNoWL4OBkCu/x2Nkv383mJPfRQ17lkffeRjXnBVusfi0+sPw+s8Zh+4Fq3lz6PRpks6Qz89HNReqNteC34lwJxCoi4W13mQBnIHus8hYMG8xYmF/7QYYDT+M773iCDLDrlGjlk+BjFpOOtCWbt5Wny/wkghs6KshBIvg3Knr9HB4Woa8SX7znt3E0d4w+0Og/89U5XVQAAAABJRU5ErkJggg==" | base64 -d > 3.png

echo "iVBORw0KGgoAAAANSUhEUgAAABoAAAAhCAYAAADH97ugAAADJklEQVR42sWWEXzbURDHa8XAoBAYBAaBQKBQCBQChUAgUCgUA4PAIBAYDAqFwqAYKBQGw8JwUBgMBoPhcDj8L99bvm+XNP80nfT/+dznvf+7e/e7u3d37+3tPfd3ctiszo5bQeP+q+ry7DDGbvtF+X8zaMdcOfbsDIAiNg17L2NEGXT7+riAMfoP792oG+QedDwKgjDKUHB9fhTK5uNezFXO+OXtsPo46RcgRg3Bs61gMBFaB0ExSj9NTwqxpgF6LRjG9joHm4HarUbluSC87gnKf1ydF8IjPTR0eKN36EJnLZChyECAoBiAn9fjIMHgK89evOF/KxBCCM+GneIVVqKM0GVv7meDMAQSxLA96lEGAkCQfPiOADHqeQZiH2dUCwQzC5rKhE5ARgkwvbXePGcSqxYIJgBmnyEUINeRQMgw10BTe6tHCEgmBiBmFUpRoHJChvUefgbZekZ2BQVNdeMvz44BGHs8fA20HT0AIsa5jtiYFRoukwWeQJ6HI+sZCN0rQHqhggxmeFBEKE0a1vjPYO5FF3IrQFibgWCigLn9D2L+7eK0AJmRrEGkPv8ZCJkCZDrDhMEmqj9bK5CpbZgEsmswz+eJ7gJECAyRHSFTBvK88FrQTXtyyFdCl4EYv04m1dn+PkJBzPFYwEicNX7sWerQ+JXQ8YluW8FyNn7oLyzvdquL1r+bVj5r8JBBNnsr0IM6EsiYq8zNdAHWf99Oq+ruKuasrcuxbkLUAsGk2hGuPt8E/ZpPQrnXAyCQ//CQUZ69NtmNQHx2AO8gFKKIjCIc2QDmXh16afO1m9Re5XpkfRSQwaDUl55oNTzB2JOvjVogizDXB0X4vtOJrGLd4mR+uliDh0w+G9vV1peQLyAvt7vR6O9r5+AgFJe3XqMRBA8ZL0J7405vOwRVQOpCwwVIn3pZAs2azaD50VHwNWhnEEPojRoKFudgvdyPx0HWF3zIy/HRkG0C8z3HYVOckA2WMEJmJLJPBskhJIOiry2sx7Pv02lkGHOIREDmSSGr8wxFnMdNr1ey7rLdDoL3356sf7R7wkToyvthmQy1T9/n+v4ARprwUydij+gAAAAASUVORK5CYII=" | base64 -d > 4.png

echo "iVBORw0KGgoAAAANSUhEUgAAABoAAAAhCAYAAADH97ugAAADXUlEQVR42sWWK1RbQRCG4xAIRAUCgYioiIiIQCAiEBGICAQiAoFAXFEREYFAIBCICkQFEoFAVCARSASioqISWVlZub3fNN+yN5AAreCeM2cfM/v/O4/dva3We3/bG2tpb6sdUg0+ps97G9H2Oh/yeDLsRF871ryaACAW7fTXowUMufq0lcloHaM72e2FuAaMF0kwBgyA8/3NALuo+tEXnPbb8U66Hg8yEa0bwbOFZCgxmiUBGNDbw+0szLkBvZaMzfa7q88TddorybxgPOsJ4A9n+1nwSA8NHd7oHVhgziUyFCURJABD8OtinIkMn/asxRvGC4kwwvhop5u9YpeQASiZBGyEviSG7UWPSiIIJCmTb4uXtIAzVxKxjhzNJUJZGlrKAElIq0Cmt54380xhzSVCCYHVZwglKM+RxNjQd4OW9kKPMFAsDMCsKkABEJwcsXuTX5IszJHuamipG3/G6LwxIGONyac/WlrK19ETImJcniMWloCGi/C4Y4nMx6DVepYI7AZR3TRuhWE9lszwAOS850WSg1qiYtfWsodgNojYreHKO613NpzuElC9KYlYF/raFmF82m5nIuyYy0SWM8o4qJP6EHY6QWZoJPJ8mRv0571eOlhejnXXw2Ejn9hmIkJgiI6r7TAkBEje9ZQIYY6QeJ5iQ1OPEDDKkDdCp8I+O2MxcUbo47GEUTgz+q+DQcZw843Q8cke10odgng5p+C+olafB9c5PQr95PGiRf/kHEnEtRI5moZP8PujYfpxOkq/rw5TujmLPnMRqvX1EPMLhvl7lgglpx2Q7+NxCM8C4D/PqxBIEMfoHk5O0u1olNLdZawFYy4RnzcAcrf/94ELoLolHIAAJiBz6G52dyOnEY3perDmPuV6RCVd9vv5NQUEHcB64q7RYYt4m6tb+IPiyxrvTQ3CE/Gl241ksxhPEPpcN+g4RwhrWOt1tZDI5LN7EkxYqpWVNFldzfdYVFs9p3C4ER/CxiF9iYxFVB1nA+GKGdfnxQqjj/5iczP04VkdtleT8OE2iwAy0YQGwPuqCqHPHATY0PoT+aZfYhZAZGUJSoi4OBlbMNigezNJGUKSKxCeeb7oWyzYoP+vn33/BfAEMEtZYkj+2ZPZj+ueiiNkpRDaub++7/X9AT7swLVgYP7bAAAAAElFTkSuQmCC" | base64 -d > 5.png

fi

#loop through and check load average then change image
while true
do

#Throttle checking interval here
sleep 10

#Get load avg for the past 5 min.
loadavg="$(cat /proc/loadavg | cut -d " " -f2 | tr -d . | sed -e '/0/s/^./ /' | tr -d " ")"

#Print load avg on screen
echo $loadavg

#Set load average for first level of doom guy's face
if [ "$loadavg" -lt 20 ]
then
	qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var panel=panelById(panelIds[0]),widg=panel.widgets();for(i=0;i<widg.length;i++)if("org.kde.plasma.kickoff"==widg[i].type){var widgnum=JSON.stringify(widg[i].id);print(widgnum)}var widgdoom=panel.widgetById(widgnum);widgdoom.writeConfig("icon","'$HOME'/doomguy/1.png");'

#Set load average for second level of doom guy's face. Dbus is used to execute Plasma JS.
elif [ "$loadavg" -lt 40 ]
then
	qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var panel=panelById(panelIds[0]),widg=panel.widgets();for(i=0;i<widg.length;i++)if("org.kde.plasma.kickoff"==widg[i].type){var widgnum=JSON.stringify(widg[i].id);print(widgnum)}var widgdoom=panel.widgetById(widgnum);widgdoom.writeConfig("icon","'$HOME'/doomguy/2.png");'

#Set load average for third level of doom guy's face. Dbus is used to execute Plasma JS.
elif [ "$loadavg" -lt 60 ]
then
	qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var panel=panelById(panelIds[0]),widg=panel.widgets();for(i=0;i<widg.length;i++)if("org.kde.plasma.kickoff"==widg[i].type){var widgnum=JSON.stringify(widg[i].id);print(widgnum)}var widgdoom=panel.widgetById(widgnum);widgdoom.writeConfig("icon","'$HOME'/doomguy/3.png");'

#Set load average for fourth level of doom guy's face. Dbus is used to execute Plasma JS.
elif [ "$loadavg" -lt 80 ]
then
	qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var panel=panelById(panelIds[0]),widg=panel.widgets();for(i=0;i<widg.length;i++)if("org.kde.plasma.kickoff"==widg[i].type){var widgnum=JSON.stringify(widg[i].id);print(widgnum)}var widgdoom=panel.widgetById(widgnum);widgdoom.writeConfig("icon","'$HOME'/doomguy/4.png");'

#Set load average for fifth level of doom guy's face. Dbus is used to execute Plasma JS.
elif [ "$loadavg" -gt 90 ]
then
	qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var panel=panelById(panelIds[0]),widg=panel.widgets();for(i=0;i<widg.length;i++)if("org.kde.plasma.kickoff"==widg[i].type){var widgnum=JSON.stringify(widg[i].id);print(widgnum)}var widgdoom=panel.widgetById(widgnum);widgdoom.writeConfig("icon","'$HOME'/doomguy/5.png");'

fi
done
