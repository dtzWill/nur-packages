self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-04-18";
    src = super.fetchFromGitHub {
      owner = "AwesomeWM"; # "dtzWill";
      repo = "awesome";
      rev = "7ff635bde004ccfc089710c540e5d729e5aae91d";
      sha256 = "0z5lh1q50a2iawr1cc8nrk5kds2mxkink3kgawighgw7gsycx7dy";
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
     (builtins.toFile "notification-action-fix-dbus.patch" ''
        diff --git a/lib/naughty/dbus.lua b/lib/naughty/dbus.lua
        --- a/lib/naughty/dbus.lua        2019-04-06 21:36:17.191213289 +0200
        +++ b/lib/naughty/dbus.lua     2019-04-06 21:38:13.551108079 +0200
        @@ -214,6 +214,10 @@
                             notification = nnotif(args)
                         end
        
        +                for _, a in ipairs(args.actions) do
        +                    a._private.notification = notification
        +                end
        +
                         return "u", notification.id
                     end
     '')
   ];

    #doCheck = true;
  });
}
