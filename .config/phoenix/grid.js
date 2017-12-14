class Grid {
    constructor(rect, rows, columns) {
        this.rect = rect
        this.rows = rows
        this.columns = columns
    }

    resizeWindow(win, row, column, rowSpan = 1, columnSpan = 1) {
        let x = this.rect.width / this.columns * column
        let y = this.rect.height / this.rows * row
        let width = this.rect.width / this.columns * columnSpan
        let height = this.rect.height / this.rows * rowSpan

        win.setFrame({ x, y, width, height })
    }
}

