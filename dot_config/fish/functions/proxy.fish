function proxy -d 'manage proxy: proxy restart|set|unset'
    switch $argv[1]
        case restart
            launchctl kill TERM "gui/$(id -u)/cc.colorto.proxydetox"
            launchctl kickstart "gui/$(id -u)/cc.colorto.proxydetox"
        case set
            set -gx http_proxy 127.0.0.1:3128
            set -gx https_proxy 127.0.0.1:3128
            set -gx no_proxy 127.0.0.1,localhost,.bmwgroup.net,.cloud.bmw
        case unset
            set -e http_proxy
            set -e https_proxy
            set -e no_proxy
        case '*'
            echo "Usage: proxy restart|set|unset"
            return 1
    end
end
