"Goals for enav.vim:
"   
"   Efficient movement - moving 1 line or character is too inefficient.  
" 
"   j/k -  page up/down 
"   h/l -  previous/next paragraph
"
" I use the easymotion plug-in to navigate screen 

"  values: 0 and 1
let g:autozz_enabled = 1

"  values: 0-100
"     0  - will lock the active line at top of screen, 
"     50 - place
"     active line at middle, 100 - place active line at bottom
let g:autozz_percent = 33

""""" Paragraph Settings """"""
"  values: 1-1000, higher value will make paragraph scrolling slower
let g:autozz_paragraph_scroll_sleep = 1500          " 0 is a valid value, it will be instant

"  values: 0-5, higher will make paragraph scrolling faster
let g:autozz_paragraph_scroll_pause_on_lines = 1   " 0 is a valid value, it will be instant

""""" Page Settings """"""
"  values: 1-1000, higher value will make page scrolling slower
let g:autozz_page_scroll_sleep = 1

" values: 0 - 10
" 0 - no scrolling, will instantly display next page
let g:autozz_page_scroll_pause_on_lines = 5   " higher will scroll faster

let g:span_split = 0

function! PrepWindows()
    windo set noscrollbind
    execute "normal! mp"
    let number_of_windows = winnr('$')
    let current_window = 1
    execute current_window . "wincmd w"
    " let top_line_from_next_page = line('w$') + 1
    let current_window = current_window + 1
    while current_window <= number_of_windows
        let top_line_from_next_page = line('w$') + 1
        execute current_window . "wincmd w"
        execute "normal! " . top_line_from_next_page . "zt"
        let current_window = current_window + 1
    endwhile
    normal "\<C-w>h"
    " execute 1 . " wincmd w"
    windo set scrollbind
endfunction
command! Pp call PrepWindows()

function! ScrollUp()
    execute "normal! \<up>"
    if g:autozz_enabled
        let autozz_screen_position = ( winheight(0) * g:autozz_percent ) / 100
        execute "normal! zt" . autozz_screen_position . "\<C-y>"
    endif
endfunction

function! ScrollDown()
    execute "normal! \<down>"
    if g:autozz_enabled
        let autozz_screen_position = ( winheight(0) * g:autozz_percent ) / 100
        execute "normal! zt" . autozz_screen_position . "\<C-y>"
    endif
endfunction

function! MoveUp()
    if g:autozz_enabled
        execute "normal! \<C-e>"
    endif
endfunction

function! MoveDown()
    if g:autozz_enabled
        execute "normal! \<C-y>"
    endif
endfunction

function! PrevParagraph()
    normal! mp
    execute "normal! {{"
    call search('\S')
    let next_jump = line(".")
    normal! 'p
    let lines_to_scroll = line(".") - next_jump
    call Scroll('scroll_up', lines_to_scroll, g:autozz_paragraph_scroll_pause_on_lines, g:autozz_paragraph_scroll_sleep)
endfunction

" Place cursor on 1st line next non-white space paragraph 
function! NextParagraph()
    normal! mp
    execute "normal! }j"
    let next_jump = line(".")
    normal! 'p
    let lines_to_scroll = next_jump - line(".")
    call Scroll('scroll_down', lines_to_scroll, g:autozz_paragraph_scroll_pause_on_lines, g:autozz_paragraph_scroll_sleep)
endfunction

function! JumpToFirstLineInBlock()
    let orginal_line = line(".") 
    normal! {j
    let target_line = line(".") 
    if target_line == orginal_line
        normal! {{j
        let target_line = line(".") 
    endif
    if g:autozz_enabled
        exec "normal! " . orginal_line . "gg"
        call Scroll('scroll_up', abs(orginal_line - target_line), g:autozz_paragraph_scroll_pause_on_lines, g:autozz_paragraph_scroll_sleep)
    endif
endfunction

function! JumpToLastLineInBlock()
    set lazyredraw
    let orginal_line = line(".") 
    normal! }k
    let bottom_of_paragraph_line = line('.')
    if orginal_line == bottom_of_paragraph_line
        normal! }}k
        let bottom_of_paragraph_line = line('.')
    endif
    if g:autozz_enabled
        exec "normal! " . orginal_line . "gg"
        call Scroll('scroll_down', abs(bottom_of_paragraph_line - orginal_line), g:autozz_paragraph_scroll_pause_on_lines, g:autozz_paragraph_scroll_sleep)
    else
    endif
    set lazyredraw!
endfunction

function! DisplaySpanningSplits() " view file across multiple vsplits
    if winnr('$') > 1
        let next_window = 2
        let next_top = line("w$") + 1
        while next_window <= winnr('$')
            execute next_window . "wincmd w"
            execute "normal! " . next_top . "zt"
            let next_top = line("w$") + 1
            let next_window = next_window + 1
        endwhile
        execute 1 . "wincmd w"
    endif
endfunction

" Usage: Scroll('up', 10, 5) 
" 1: scroll_direction, 2: number of rows to scroll, 3: pauses every g:page_scroll_delay every x lines
function! Scroll(...)
    let scroll_direction = a:1      " 'scroll_up', 'scroll_down', 'move_up', 'move_dow'
    let lines_to_scroll = a:2       " number of lines to scroll
    let scroll_line_to_pause = a:3  " to speed up scrolling, only pause on every x lines
    let sleep_in_ms = a:4
    " echo "scroll_direction: " . scroll_direction . " lines_to_scroll: " . lines_to_scroll . " scroll_line_to_pause: " . scroll_line_to_pause
    let i = 0
    while i < lines_to_scroll
        if scroll_direction == 'scroll_up'
            call ScrollUp()
        elseif scroll_direction == 'scroll_down'
            call ScrollDown()
        elseif scroll_direction == 'move_up'
            call MoveUp()
        else
            call MoveDown()
        endif
        if i / scroll_line_to_pause == i / (scroll_line_to_pause * 1.0)
            redraw
            " execute "sleep " . 1 . "m"
            execute "sleep " . sleep_in_ms . "m"
        endif
        let i = i + 1
    endwhile
    " echo "sleep: " . sleep_in_ms . " lines before pause: " . scroll_line_to_pause
endfunction

function! PageUp()
    if g:autozz_page_scroll_sleep != 0 && g:autozz_page_scroll_pause_on_lines != 0 && g:autozz_enabled
        call Scroll('scroll_up', winheight(0), g:autozz_page_scroll_pause_on_lines, g:autozz_page_scroll_sleep)
    else
        let screen_line_position = line('.') - line('w0') 
        let next_bottom_line = line('w0') - 1
        execute "normal! " . next_bottom_line . "zbH"
        execute "normal! " . screen_line_position . "\<Down>_"
    endif
endfunction

function! PageDown()
    let current_line = line('.')
    if g:autozz_page_scroll_sleep != 0 && g:autozz_paragraph_scroll_pause_on_lines != 0 && g:autozz_enabled
        let autozz_screen_position = ( winheight(0) * g:autozz_percent ) / 100
        if current_line >= autozz_screen_position 
            call Scroll('scroll_down', winheight(0), g:autozz_page_scroll_pause_on_lines, g:autozz_page_scroll_sleep)
        else
            call Scroll('scroll_down', winheight(0) + autozz_screen_position - current_line + 1, g:autozz_page_scroll_pause_on_lines, g:autozz_page_scroll_sleep)
        endif
    else
        let screen_line_position = line('.') - line('w0') 
        let next_top_line = line('w0') + winheight(0)
        execute "normal! " . next_top_line . "zt"
        execute "normal! " . screen_line_position . "\<Down>_"
    endif
endfunction

function! PageUpSpanningSplits()
    let number_of_windows = winnr('$')
    let window_height = winheight(0)
    let next_top_line = line('w0') - number_of_windows * window_height
    if next_top_line < 1
        let next_top_line = 1
    endif
    if g:autozz_enabled
        let autozz_screen_position = ( winheight(0) * g:autozz_percent ) / 100
        execute "normal! " . next_top_line . "zt" . autozz_screen_position . "\<ScrollDown>"
    else
        execute "normal! " . next_top_line . "zt"
    endif
    call DisplaySpanningSplits()
endfunction

function! PageDownSpanningSplits()
    if winnr('$') > 1
        let last_window = winnr('$')
        execute last_window . "wincmd w"
        let next_top_line = line("w$") + 1
        execute 1 . "wincmd w"
        if g:autozz_enabled
        else
            execute "normal! " . next_top_line . "zt"
        let lines_from_top = line(".")
        call DisplaySpanningSplits()
    endif
endfunction

function! JumpToMark()
    exe "normal }"
endfunction 

function! UpperN()
    set lazyredraw
    normal! Nmn   " mark n
    call ZZ()
    normal! `n
    set nolazyredraw
endfunction

function! LowerN()
        set lazyredraw
        normal! nmn
        call ZZ()
        normal! `n
        set nolazyredraw
endfunction

function! ZZ()
    let autozz_screen_position = ( winheight(0) * g:autozz_percent ) / 100
    if g:autozz_enabled
        let top_line = line('w0')
        let autozz_line_number = top_line + autozz_screen_position
        let current_line = line('.')
        if current_line > autozz_line_number 
            let lines_to_scroll = current_line - autozz_line_number
            call Scroll('move_up', lines_to_scroll, g:autozz_paragraph_scroll_pause_on_lines, g:autozz_paragraph_scroll_sleep) " TODO
        else
            let lines_to_scroll = autozz_line_number - current_line
            call Scroll('move_down', lines_to_scroll, g:autozz_paragraph_scroll_pause_on_lines, g:autozz_paragraph_scroll_sleep) " TODO
        endif 
    else
        normal! zz
    endif
endfunction

function! JumpToNextBlock(...)
    let orginal_line = line('.')
    let direction = a:1      " 'up' - jump to next block up, anything else is 'down'
    if direction == 'up'
        normal! k_
    else
        normal! j_
    endif
    let save_beginning_column = col('.')
    let current_beginning_column = col('.')
    let last_line_of_file = line('$')
    while save_beginning_column == current_beginning_column && line('.') != last_line_of_file  && line('.') != 1
        if direction == 'up'
            normal! k_
        else
            normal! j_
        endif
        let current_beginning_column = col('.')
    endwhile
    if direction == 'up'
        if save_beginning_column < current_beginning_column
            normal! j_
        endif
    else
        if save_beginning_column < current_beginning_column
            normal! k_
        endif
    endif
    if g:autozz_enabled
        if direction == 'down'
            call Scroll('move_up', abs(line('.') - orginal_line), g:autozz_paragraph_scroll_pause_on_lines, g:autozz_paragraph_scroll_sleep)
        endif
        if direction == 'up'
            call Scroll('move_down', abs(line('.') - orginal_line), g:autozz_paragraph_scroll_pause_on_lines, g:autozz_paragraph_scroll_sleep)
        endif
    endif
endfunction

" autocmd! BufEnter * call InitialCursorPlacement()

" doesn't work inside tmux
nnoremap   <silent> <A-j>       :call ScrollDown()<cr>
nnoremap   <silent> <A-k>       :call ScrollUp()<cr>
nnoremap   <silent> <A-h>       <Left>
nnoremap   <silent> <A-l>       <Right>

nnoremap   <silent> <C-j>       :call ScrollDown()<cr>
nnoremap   <silent> <C-k>       :call ScrollUp()<cr>
nnoremap   <silent> <C-h>       <Left>
nnoremap   <silent> <C-l>       <Right>

" nnoremap   <silent> <A-j>       :echo 'call ScrollDown()'<cr>
" nnoremap   <silent> <A-k>       :echo 'call ScrollUp()'<cr>

nnoremap     <silent> <PageUp>           :call PageUpSpanningSplits()<CR>
"             let autozz_screen_position =0 ( winheight(0) * g:autozz_percent ) / 100
"             execute "normal! " . next_top_line . "zt" . autozz_screen_position . "\<ScrollDown>"
nnoremap     <silent> <PageDown>         :call PageDownSpanningSplits()<CR>
nnoremap     <silent> <Down>             :call ScrollDown()<cr>
nnoremap     <silent> <Up>               :call ScrollUp()<cr>
nnoremap     <silent> k                  :call PageUp()<CR>
nnoremap     <silent> j                  :call PageDown()<CR>
" nnoremap     <silent> k                  :call SSpu()<CR>
" nnoremap     <silent> j                  :call SSpd()<CR>
nnoremap     <silent> h                  :call PrevParagraph()<CR>
nnoremap     <silent> l                  :call NextParagraph()<CR>
" nnoremap     <silent> h                  :call SSpp()<CR>
" nnoremap     <silent> l                  :call SSnp()<CR>

let visual_prefix_jump=":<C-U>exe \"normal! gv\"\\\|"   " from ]] next function
nnoremap     <silent> H                  :call JumpToFirstLineInBlock()<CR>
execute "vnoremap  <silent> H " . visual_prefix_jump . "call JumpToFirstLineInBlock()<CR>"
nnoremap     <silent> L                  :call JumpToLastLineInBlock()<CR>
execute "vnoremap  <silent> L " . visual_prefix_jump . "call JumpToLastLineInBlock()<CR>"
nnoremap     <silent> J                  :call JumpToNextBlock('down')<cr>
execute "vnoremap  <silent> J " . visual_prefix_jump . "call JumpToNextBlock('down')<cr>"
nnoremap     <silent> K                  :call JumpToNextBlock('up')<cr>
execute "vnoremap  <silent> K " . visual_prefix_jump . "call JumpToNextBlock('up')<cr>"

nnoremap     <silent> n                  :call LowerN()<CR>
nnoremap     <silent> gn                 n
nnoremap     <silent> N                  :call UpperN()<CR>
nnoremap     <silent> gN                 N

nnoremap     <silent> +                  J
nnoremap   gH          H
nnoremap   gL          L
nnoremap   gM          M
" nnoremap   gh          h
nnoremap   gl          l
nnoremap   zz            :call ZZ()<CR>

" nnoremap            SS       :let g:span_split=!g:span_split<CR>:echo "g:span_split: " . g:span_split<CR>
nnoremap            Sl        :let g:autozz_enabled=!g:autozz_enabled<CR>:echo "g:autozz_enabled: " . g:autozz_enabled<CR>

map ; %
nnoremap f; ;
nnoremap sn * \| <silient> :call ZZ()<cr>

" map gje  ]%
" map gke  [%

" map gjh  ]-
" map gjl  ]+

" map gkh  [-   " jump prev inner block
" map gkl  ]+

" map gjj  ]=
" map gkk  [=

nnoremap dp Vapd
    nmap dJ <Down>Viid

if has("gui_running")
    let g:autozz_paragraph_scroll_sleep = 5          " 0 is a valid value, it will be instant
    let g:autozz_paragraph_scroll_pause_on_lines = 1   " 0 is a valid value, it will be instant
    let g:autozz_page_scroll_sleep = 0
    let g:autozz_page_scroll_pause_on_lines = 5   " higher will scroll faster
    let g:autozz_percent = 33
else
    let g:autozz_paragraph_scroll_sleep = 5          " 0 is a valid value, it will be instant
    let g:autozz_paragraph_scroll_pause_on_lines = 1   " 0 is a valid value, it will be instant
    let g:autozz_page_scroll_sleep = 0
    let g:autozz_page_scroll_pause_on_lines = 5   " higher will scroll faster
    let g:autozz_percent = 33
endif
