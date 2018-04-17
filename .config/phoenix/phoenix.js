require('./constants.js')
require('./helpers.js')
require('./grid.js')

Key.on('left', PREFIX, () => {
    let { window, grid } = buildGridForCurrentWindow(1, 2)
    grid.resizeWindow(window, 0, 0)
})

Key.on('right', PREFIX, () => {
    let { window, grid } = buildGridForCurrentWindow(1, 2)
    grid.resizeWindow(window, 0, 1)
})

Key.on('up', PREFIX, () => {
    let { window, grid } = buildGridForCurrentWindow(1, 1)
    grid.resizeWindow(window, 0, 0)
})

Key.on('1', PREFIX, sameKeyChord(isChord => {
    let { window, grid } = buildGridForCurrentWindow(1, 3)
    grid.resizeWindow(window, 0, 0, 1, isChord ? 2 : 1)
}))

Key.on('2', PREFIX, sameKeyChord(isChord => {
    let { window, grid } = buildGridForCurrentWindow(1, 3)
    grid.resizeWindow(window, 0, 1, 1, isChord ? 2 : 1)
}))

Key.on('3', PREFIX, () => {
    let { window, grid } = buildGridForCurrentWindow(1, 3)
    grid.resizeWindow(window, 0, 2)
})
