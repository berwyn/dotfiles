function sameKeyChord(callback) {
    let invocations = 0
    return () => {
        invocations += 1
        callback(invocations % 2 === 0)
        setTimeout(() => invocations = 0, 250)
    }
}

function frameFor(window) {
    return window.screen().flippedVisibleFrame()
}

function buildGridForCurrentWindow(rows, columns) {
    let window = Window.focused()
    let grid = new Grid(frameFor(window), rows, columns)
    return { window, grid }
}

