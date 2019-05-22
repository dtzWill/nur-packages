self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-04-18";
    src = super.fetchFromGitHub {
      owner = "AwesomeWM"; # "dtzWill";
      repo = "awesome";
      rev = "a92adb8b2160bcddd8d2e01743dad40198e1c89a";
      sha256 = "1jb7lrzb5xc9g1kgqz0yp2diiicsgvxl6n5l4nc0clsls7q02kcy";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];
    patches = (o.patches or []) ++ [
     (builtins.toFile "notification-action-fix.patch" ''
        From 007af75353484cbefe7611db07615fd0771757ac Mon Sep 17 00:00:00 2001
        From: Will Dietz <w@wdtz.org>
        Date: Sun, 21 Apr 2019 21:02:26 -0500
        Subject: [PATCH] fix notification actions
        
        https://github.com/awesomeWM/awesome/pull/2740#issuecomment-480532583
        ---
         lib/naughty/action.lua | 7 +++++++
         1 file changed, 7 insertions(+)
        
        diff --git a/lib/naughty/action.lua b/lib/naughty/action.lua
        index a16a9570..b4907b41 100644
        --- a/lib/naughty/action.lua
        +++ b/lib/naughty/action.lua
        @@ -86,6 +86,10 @@ for _, prop in ipairs { "name", "icon", "notification" } do
             end
         
             action["set_"..prop] = function(self, value)
        +        local old
        +        if prop == "notification" then
        +            old = self._private.notification
        +        end
                 self._private[prop] = value
                 self:emit_signal("property::"..prop, value)
         
        @@ -93,6 +97,9 @@ for _, prop in ipairs { "name", "icon", "notification" } do
                 if self._private.notification then
                     self._private.notification:emit_signal("property::actions")
                 end
        +        if old then
        +            old:emit_signal("property::actions")
        +        end
             end
         end
         
        -- 
        2.21.GIT
     '')
   ];

    #doCheck = true;
  });
}
