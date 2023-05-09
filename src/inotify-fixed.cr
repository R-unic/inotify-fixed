require "./inotify-fixed/version"

{% skip_file unless flag?(:linux) %}

require "./inotify-fixed/lib_inotify"
require "./inotify-fixed/settings"
require "./inotify-fixed/event"
require "./inotify-fixed/watcher"

module Inotify
  # Same as `Inotify::Watcher.new`.
  def self.watcher(recursive : Bool = false) : Inotify::Watcher
    Watcher.new(recursive)
  end

  # All-in-one method to create inotify instance to watch one path.
  def self.watch(path : String, recursive : Bool = false, &block : Inotify::Event ->) : Inotify::Watcher
    inotify = Inotify.watcher recursive
    inotify.on_event &block
    inotify.watch path
    inotify
  end
end
