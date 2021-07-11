const c = @import("c.zig").c;
const std = @import("std");
const panic = std.debug.panic;

var display: *c.Display = undefined;
var screen: i32 = 0;
var root: c.Window = undefined;
var cursor: u64 = undefined;

pub fn init() void {
    display = c.XOpenDisplay(null) orelse @panic("unable to create window");
    screen = c.XDefaultScreen(display);
    root = c.XRootWindow(display, screen);

    cursor = c.XCreateFontCursor(display, 2);
    var windowAttributes: c.XSetWindowAttributes = undefined;
    windowAttributes.event_mask = c.SubstructureNotifyMask | c.SubstructureRedirectMask | c.KeyPressMask | c.EnterWindowMask | c.FocusChangeMask | c.PropertyChangeMask | c.PointerMotionMask | c.NoEventMask;
    windowAttributes.cursor = cursor;
    _ = c.XChangeWindowAttributes(display, root, c.CWEventMask | c.CWCursor, &windowAttributes);
    _ = c.XSelectInput(display, root, windowAttributes.event_mask);
    _ = c.XSync(display, 0);
}

pub fn deinit() void {
    _ = c.XCloseDisplay(display);
}
