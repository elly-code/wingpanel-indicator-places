
namespace Places.Utils {
    const string[] REMOTE_PROTOCOLS = {"smb", "ssh", "ftp", "net", "dav"};

    public string get_user_icon (string path) {
        if (path[0:3] in REMOTE_PROTOCOLS) {
            return "folder-remote";
        }

        string unescaped_path = GLib.Uri.unescape_string (path);
        string _path = unescaped_path.substring (7);

        if (_path == GLib.Environment.get_user_special_dir (GLib.UserDirectory.DESKTOP)) {
            return "user-desktop";
        } else if (_path == GLib.Environment.get_user_special_dir (GLib.UserDirectory.DOCUMENTS)) {
            return "folder-documents";
        } else if (_path == GLib.Environment.get_user_special_dir (GLib.UserDirectory.DOWNLOAD)) {
            return "folder-download";
        } else if (_path == GLib.Environment.get_user_special_dir (GLib.UserDirectory.MUSIC)) {
            return "folder-music";
        } else if (_path == GLib.Environment.get_user_special_dir (GLib.UserDirectory.PICTURES)) {
            return "folder-pictures";
        } else if (_path == GLib.Environment.get_user_special_dir (GLib.UserDirectory.PUBLIC_SHARE)) {
            return "folder-publicshare";
        } else if (_path == GLib.Environment.get_user_special_dir (GLib.UserDirectory.TEMPLATES)) {
            return "folder-templates";
        } else if (_path == GLib.Environment.get_user_special_dir (GLib.UserDirectory.VIDEOS)) {
            return "folder-videos";
        } else {
            return "folder";
        }
    }

    public bool if_trash_empty () {
        var trash_path = GLib.Environment.get_home_dir () + "/.local/share/Trash/files/";

        GLib.Dir trash;
        bool is_empty = true;

        try {
            trash = GLib.Dir.open (trash_path);
            is_empty = (trash.read_name () == null);

        } catch (Error e) {
            print (e.message);
        }

        return is_empty;
    }
}
