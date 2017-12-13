Key.on('left', ['cmd', 'ctrl'], () => {
    let win = Window.focused()
    let screen = win.screen().flippedVisibleFrame()

    win.setTopLeft({ x: 0, y: 0 })
    win.setSize({ width: screen.width / 2, height: screen.height })
})

Key.on('right', ['cmd', 'ctrl'], () => {
    let win = Window.focused()
    let screen = win.screen().flippedVisibleFrame()

    win.setTopLeft({ x: screen.width / 2, y: 0 })
    win.setSize({ width: screen.width / 2, height: screen.height })
})

Key.on('1', ['cmd', 'ctrl'], () => {
    let win = Window.focused()
    let screen = win.screen().flippedVisibleFrame()

    win.setTopLeft({ x: 0, y: 0 })
    win.setSize({ width: screen.width / 3, height: screen.height })
})

Key.on('2', ['cmd', 'ctrl'], () => {
    let win = Window.focused()
    let screen = win.screen().flippedVisibleFrame()

    win.setTopLeft({ x: screen.width / 3, y: 0 })
    win.setSize({ width: screen.width / 3, height: screen.height })
})

Key.on('3', ['cmd', 'ctrl'], () => {
    let win = Window.focused()
    let screen = win.screen().flippedVisibleFrame()

    win.setTopLeft({ x: screen.width / 3 * 2, y: 0 })
    win.setSize({ width: screen.width / 3, height: screen.height })
})
