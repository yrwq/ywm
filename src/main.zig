const std = @import("std");
const xlib = @import("xlib.zig");
const c = @import("c.zig");

pub fn main() anyerror!void {
    xlib.init();
    defer xlib.deinit();
}
