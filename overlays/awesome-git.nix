self: super: {
  # XXX: This assumes base 'awesome' is 4.3(+?), which it is on master
  awesome = super.awesome.overrideAttrs (o: rec {
    pname = "awesome";
    name = "${pname}-${version}"; # override
    version = "2019-03-13";
    src = super.fetchFromGitHub {
      owner = "AwesomeWM";
      repo = "awesome";
      rev = "d8687dc251a62a5620fea577369ffda9bbb6c9b0";
      sha256 = "12s109mg8wmxyrc4qkc1k8ip758k5q32vd8cm6lg2n60q7h8n0l4";
    };
    buildInputs = (o.buildInputs or []) ++ [ self.xorg.xcbutilerrors ];
    patches = (o.patches or []) ++ [
      (builtins.toFile "notification-destroy.patch" ''
From e718c94b08c6955d0ad6111cd05954626b23df56 Mon Sep 17 00:00:00 2001
From: Will Dietz <w@wdtz.org>
Date: Sat, 16 Mar 2019 14:37:44 -0500
Subject: [PATCH] don't replace 'destroy' in existing notification, set
 destroy_cb

---
 lib/naughty/dbus.lua | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/naughty/dbus.lua b/lib/naughty/dbus.lua
index f812b117..40207914 100644
--- a/lib/naughty/dbus.lua
+++ b/lib/naughty/dbus.lua
@@ -216,6 +216,7 @@ capi.dbus.connect_signal("org.freedesktop.Notifications",
 
                 if notification then
                     for k, v in pairs(args) do
+                        if k == "destroy" then k = "destroy_cb" end
                         notification[k] = v
                     end
                 else
-- 
2.21.GIT

      '')
    ];
  });
}
