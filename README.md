
<div align="center">
  <h1 align="center">Wingpanel Places Indicator</h1>
  <h3 align="center">Manage disks, volumes, places from the panel</h3>
    <a href="https://elementary.io">
        <img src="https://elly-code.github.io/community-badge.svg" alt="Made for elementary OS">
    </a>
</div>

<div align="center">
    <span align="center">
        <img class="center" src="data/screenshot1.png" alt="Places indicator">
    </span>
</div>
</br>

<p align="left">
    <a href="https://paypal.me/Dirli85">
        <img src="https://img.shields.io/badge/Donate-PayPal-green.svg">
    </a>
</p>

## For Debian
When mounting volumes, problems with access rights are possible.
My decision /usr/share/polkit-1/actions/org.freedesktop.UDisks2.policy:

    <action id="org.freedesktop.udisks2.filesystem-mount-system"\>  
        ...  
        <defaults\>  
            <allow_any>yes</allow_any\>  
            <allow_inactive>yes</allow_inactive\>  
            <allow_active>yes</allow_active\>  
        </defaults>  
    </action\>

## Building and Installation


In Release there is a deb file


### You'll need the following dependencies to build:
* valac
* libgtk-3-dev
* libgranite-dev
* libwingpanel-2.0-dev
* meson

### How to build
    meson build --prefix=/usr
    ninja -C build
    sudo ninja -C build install
