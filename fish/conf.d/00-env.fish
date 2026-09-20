# Fast non-interactive shells: suppress mise auto-activation in vendor_conf.d
# (Mise shims in PATH provide full tool access with 0 startup overhead)
if not status is-interactive
    set -gx MISE_FISH_AUTO_ACTIVATE 0
end
