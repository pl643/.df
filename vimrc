" ~/df/vimrc - BEGIN
" NOTE: Vim fold commands: zr - unfold / zm - fold

" let/set {{{
if isdirectory($HOME . "/df")
    let g:dotfile = "~/df"
    let g:plug_vim_path="~/df/nvim/plug.vim"
    let g:plug_vim_dir_path="~/df/nvim/plugged"
endif
if isdirectory("/tmp/.df")
    let g:dotfile = "/tmp/.df"
    let g:plug_vim_path="/tmp/.df/nvim/plug.vim"
    let g:plug_vim_dir_path="/tmp/.df/nvim/plugged"
endif
" echo "dotfile: " . g:dotfile

let mapleader=","
let g:deoplete#enable_at_startup = 1
let g:loaded_python_provider=0
let g:EasyMotion_smartcase = 1
" nnoremap ,oc          :r !python \%userprofile\%\\df\\ocr.py<CR>:%s//'/g<CR>
" nnoremap n :execute "normal nzt" . g:line . "\<Down>\<CR>"

" echom "line 16: " . $HOME . '/df/UltiSnips'
let g:UltiSnipsSnippetDirectories=[$HOME.'/df/UltiSnips']
" let g:UltiSnipsSnippetsDir="~/df/snippets"
" set runtimepath^=~/df/snippets
let g:UltiSnipsSnippetDirectories=["UltiSnips", "~/df/snippets"]
" let g:UltiSnipsExpandTrigger="<M-j>"               
let g:UltiSnipsExpandTrigger="<c-s>"               
" let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<M-l>"
let g:UltiSnipsJumpBackwardTrigger="<M-h>"
" echom g:UltiSnipsSnippetDirectories
" let g:UltiSnipsExpandTrigger='<Nop>'
" let g:UltiSnipsJumpForwardTrigger = '<TAB>'
" let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'

" let g:coc_snippet_next = '<M-Right>'
" let g:coc_snippet_prev = '<M-Left>'
" let g:coc_force_debug = 1

let g:center_screen = 1   " <Space>C to goggle
let g:zen_mode      = 0   " <Space>Z to toggle
let g:jk_mode       = "line"   " <Space>PL to toggle jk screen/page at a time
let g:superJK_mode   = "line"   " <line/paragraph/paragraph2/page
let g:superJK_offset = "25%"    " top is default is 25
let g:superJK_scroll = "1"      " top is default is 25
let g:screen_offset = 1.0/4.0 " 25%
" let g:screen_offset = 0
" let g:gruvbox_contrast_dark = 'hard'

" python path checks
if has('win32') || has('win64')
    if filereadable('C:\Program Files\Python38\python.exe')
        let g:python3_host_prog = 'C:\Program Files\Python38\python.exe'
    endif
    if filereadable('c:\python39\python.exe')
        let g:python3_host_prog = 'c:\python39\python.exe'
    endif
else
    let g:python3_host_prog = '/usr/bin/python3'
endif

" let g:coc_common = { "suggest.noselect": false  }

" " explorer.vim
" let g:coc_explorer = {
"       \   "explorer.icon.enableNerdfont": v:true,
"       \   "explorer.keyMappings": {
"       \     "<space>": "normal:j"
"       \   },
"       \ }
" let g:coc_user_config = extend(g:coc_common, g:coc_explorer)

set autochdir  " auto change directory to current file
set cindent
set cursorline
set foldmethod=marker   " zm/zr - fold/unfold
set foldmarker={{{,}}}
" set ff=dos
" set ffs=dos,unix
set clipboard+=unnamedplus " need for copying and pasting from windows clipboard
set expandtab      " On pressing tab, insert 4 spaces
set hidden
set inccommand=split
set incsearch
set hlsearch
set noswapfile
set nowrap
set number
set pyx=3
set viminfo='30  " limit old files to 20
" set shadafile='30  " limit old files to 20
" set scrolloff=999
" set scrolloff=0
set shiftwidth=4   " when indenting with '>', use 4 spaces width
set softtabstop=4  " Sets the number of columns for a TAB.
set splitbelow     " ss splits to bottom :split
set splitright     " sS splits to right :vsplit
set tabstop=4      " show existing tab with 4 spaces width
set tags=./tags;/
set titlestring=Dir:\ \ %{strpart(expand(\"%:p:h\"),stridx(expand(\"%:p:h\"),\"/\",strlen(expand(\"%:p:h\"))-12))}%=%n.\ \ %{expand(\"%:t:r\")}\ %m\ %Y\ \ \ \ %l\ of\ %L\ - 
set encoding=UTF-8
" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase
" set backupdir=.backup/,~/.backup/,/tmp//
" set directory=.swp/,~/.swp/,/tmp//
" set undodir=.undo/,~/.undo/,/tmp//
"}}}

" completion settings
set complete+=kspell
set completeopt=menuone,longest,preview
set updatetime=100  " gitgutter update time in ms
" set shortmess+=c
"inoremap <expr> <Right> pumvisible() ? "C-y" : "<Right>"
"inoremap <expr> <CR> pumvisible() ? "C-y" : "<CR>"

" https://vim.fandom.com/wiki/Improve_completion_popup_menu
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" nnoremap <leader> section {{{

nnoremap <leader>1 	         :<Up><cr>
nnoremap <leader>3 	         :buffer! #<cr>
nnoremap <leader>5 	         :w<cr>:source %<cr>
nnoremap <leader>S           :SmoothScrollingToggle<cr>
nnoremap <leader>bb          :buffers<cr>:buffer<space>
nnoremap <leader>bb          :buffers!<cr>:buffer!<Space>
nnoremap <leader>bd          :bdelete!<cr>
nnoremap <leader>bd          :bdelete!<cr>
nnoremap <leader>bh          :bprev!<cr>
nnoremap <leader>bh          :bprev!<cr>
nnoremap <leader>bl          :bnext!<cr>
nnoremap <leader>bl          :bnext!<cr>
nnoremap <leader>bn          :bnext!<cr>
nnoremap <leader>bp          :bprev!<cr>
nnoremap <leader>cl          :set cursorline!<cr>
nnoremap <leader>ed          :edit ~/Documents<cr>
nmap <leader>c           gcc
vmap <leader>c           gcc
vmap <c-c>               gcc
nmap <c-c>               gcc

nnoremap <leader>dw          diw
nnoremap <leader>ec          :edit!   c:/<cr>
execute "nnoremap <leader>ea  :edit!   ~/" . g:dotfile . "/ansible.vim<cr>"
execute "nnoremap <leader>eb  :edit!   ~/" . g:dotfile . "/ExecutorBuffer.java<cr>"
execute "nnoremap <leader>ee  :edit!   ~/" . g:dotfile . "/eQWERTY.ahk<cr>"
execute "nnoremap <leader>eg  :edit!   ~/" . g:dotfile . "/nvim/ginit.vim<cr>"
execute "nnoremap <leader>ei  :edit!   ~/" . g:dotfile . "/.gitignore<cr>"
nnoremap <leader>ej  :edit!   ~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
nnoremap <leader>el  :edit!   c:/sandbox/MTR/Libraries<cr>
execute "nnoremap <leader>ep  :edit!   ~/" . g:dotfile . "/profile.ps1<cr>"
nnoremap <leader>es  :edit!   ~/src/<cr>
execute "nnoremap <leader>et  :edit!   ~/" . g:dotfile . "/tap.ahk<cr>"
execute "nnoremap <leader>ev  :edit!   ~/" . g:dotfile . "/vimrc<cr>"
execute "nnoremap <leader>v   :edit!   ~/" . g:dotfile . "/vimrc<cr>"
nnoremap <leader>ex  :exe getline(line('.'))<cr>
nnoremap <leader>os  :silent ! cmd /c start  ..\AppData\Local\nvim-data\swap<cr>
nnoremap <leader>of  :silent ! start %<cr>
nnoremap <leader>ft  :set ft=

nnoremap <leader>h   :noh<cr>
nnoremap <leader>j   :jumps<cr>
nnoremap <leader>k   :48vs ergolaptop<cr>:set nonumber<cr><c-w>h
execute "nnoremap <leader>l   :source ~/" . g:dotfile . "/nvim/session.vim<cr>"
nnoremap <leader>m   :marks<cr>
nnoremap <leader>pi  :PlugInstall<cr>
nnoremap <leader>q   :quit!<cr>
"nnoremap <leader>ef  :edit ~/" . g:dotfile . "/fayevimrc<cr>"
execute "nnoremap <leader>sf  :source ~/" . g:dotfile . "/fayevimrc<cr>"
nnoremap <leader>st  vip:sort<cr>
execute "nnoremap <leader>sa  :source ~/" . g:dotfile . "/ansible.vim<cr>"
execute "nnoremap <leader>sv  :source ~/" . g:dotfile . "/vimrc<cr>"
execute "nnoremap <leader>sg  :source ~/" . g:dotfile . "/nvim/ginit.vim<cr>"
execute "nnoremap <leader>ss  :w<cr>:source ~/" . g:dotfile . "/vimrc<cr>:source " . g:dotfile . "/nvim/ginit.vim<cr>"
nnoremap <leader>t   :vsplit<cr>:set nonumber<cr>:terminal bash<cr>i
nnoremap <leader>w   :w<cr>
nnoremap <leader>z   :color zellner<cr>
nnoremap <leader>(	 f)ci(
nnoremap <leader>[	 f]ci[
nnoremap <leader>{	 f}ci{
nnoremap <leader>"	 ci"
nnoremap <leader>'	 ci'
nnoremap <leader>dp  :normal ggVG"+P<cr>
nnoremap <leader>p   :normal "+P<cr>
nnoremap <leader>rs  :vertical resize 115<cr>
nnoremap <A-v>       :normal "+P<cr>
" nnoremap <leader>zz  :let &scrolloff=999-&scrolloff<cr>
nnoremap <leader>y   :normal gg"+yG
nnoremap <leader>s   :%s/\<<C-r><C-w>\>//g<Left><Left>

" asus monitor
nnoremap ,iwa       :hi InactiveWindow          guibg=gray9     ctermbg=233<CR>
" dell 7400 laptop screen
nnoremap ,iwd      :hi InactiveWindow          guibg=gray12    ctermbg=235<CR>

" Center search results
" nnoremap n :execute "normal nzt" . g:line . "\<Down>\<CR>"
" nnoremap n :execute "normal nzt"

nnoremap <c-i> <c-o>    " swap i/o so it's more intuative (left back/right forward
nnoremap <c-o> <c-i>
" allows <c-e> for up and <c-d> for down
nnoremap <c-d> <c-y>

" nnoremap n nzz7<C-e>
" nnoremap N Nzz7<C-e>
" nnoremap * *zz7<C-e>
" nnoremap # #zz7<C-e>
" nnoremap g* g*zz7<C-e>
" nnoremap g# g#zz7<C-e>

nnoremap gm  " place holder for go map a which would search for "x map" if follow by x

" change from 1 slash to 2 slashes
nnoremap \\   :!
nnoremap \1   :s!\\\\!\\!g<cr>
nnoremap \2   :s!\\!\\\\!g<cr>

" nnoremap <expr><silent> <leader>, &showtabline ? ":set showtabline=0\<cr>" : ":set showtabline=2\<cr>"
nnoremap <expr> <leader>st &showtabline ? ":set showtabline=0\<cr>" : ":set showtabline=2\<cr>"
"}}}

" mappings {{{
" copy and paste at local location

" a map
nnoremap   a            <Nop>
nnoremap   a.           i
nnoremap   aa           a
nnoremap   A            <Nop>
nnoremap   AA           A

" c map            " C is same as c$
nnoremap   C            <Nop>
map   C            <Plug>CommentaryLine
" nnoremap   Ct           :silent !start \%userprofile\%\\df\\bin\\ctags.exe -V -f \%userprofile\%\\df\tags --language-force=java -R C:\sandbox
" nnoremap   Ct           :silent !start \%userprofile\%\\df\\bin\\ctags.exe -V -f \%userprofile\%\\df\tags -R C:\sandbox<cr>
" nnoremap   Ct           :silent !start \%userprofile\%\\df\\bin\\ctags.exe -V -f \%userprofile\%\\df\tags -R C:\sandbox<cr>
nnoremap   ch           c0
nnoremap   cl           c$
nnoremap   cgN          *Ncgn

" d map
nnoremap   D            <Nop>
nnoremap   DD           D
if has('win32') || has('win64')
    nnoremap   DF       :!del %<CR>
else
    nnoremap   DF       :!rm %<CR>
endif
nnoremap   DB           :bufdo bdelete!<CR>
nnoremap   DA           :%d_<CR>
nnoremap   DS           :call DiffWithSaved()<cr>
nnoremap   Dab          :bufdo bd<cr>     " delete all buffers
nnoremap   dl           <right>x<left>
nnoremap   dL           d$
nnoremap   dh           X
nnoremap   d.           x
nnoremap   dH           d0
nnoremap   dj           <Down>dd<Up>
nnoremap   dk           <Up>dd
nnoremap   dp           vapd

" e map 
nnoremap   e            <Nop>
nnoremap   ee           e

" f map
" nnoremap   <C-f>        :CocCommand explorer<CR>
execute "nnoremap   FEd          :Fern ~/" . g:dotfile . "<CR>"
execute "nnoremap   FGd          :GFiles ~/" . g:dotfile . "<CR>"
nnoremap   <C-f>        :Fern . -drawer -toggle<CR>
nnoremap   F            <Nop>
nnoremap   FB           :Buffers<CR>
nnoremap   FC           :CocCommand explorer<CR>
nnoremap   FE.          :Fern . -drawer -toggle<CR>
nnoremap   FED          :Fern ~/Downloads<CR>
nnoremap   FEh          :Fern ~<CR>
nnoremap   FEr          :Fern c:\<CR>
nnoremap   FEs          :Fern c:\Sandbox<CR>
nnoremap   FF           :Files<Space>
nnoremap   FF.          :Files .<CR>
nnoremap   FFh          :Files ~<CR>
nnoremap   FFr          :Files c:\<CR>
nnoremap   FFs          :Files c:\Sandbox<CR>
nnoremap   FG           :GFiles<Space>
nnoremap   FG.          :GFiles .<CR>
nnoremap   FGh          :GFiles ~<CR>
nnoremap   FGs          :GFiles c:\Sandbox<CR>
nnoremap   FS	        :let g:full_screen=!g:full_screen <bar> call GuiWindowFullScreen(g:full_screen) <bar> echom "fullscreen toggled"<CR> 
nnoremap   FT           :NERDTree<CR>
" nnoremap   Fl           :BLines<CR>
nnoremap   f            <Nop>
nnoremap   Fj           /
nnoremap   Fk           ?
map        Fh           [[
map        Fl           ]]
nnoremap   fb           :set nohlsearch<cr> \| /^\s*\<if\>\\|^\s*\<else\>\\|^\s*\<while\><cr> \| :set hlsearch<cr>
nnoremap   fe           e
nnoremap   ff           ;
nnoremap   fh           F
nnoremap   fj           /\<\><Left><Left>
nnoremap   fk           ?\<\><Left><Left>
nnoremap   fl           f
nnoremap   fz.          :FZF .<cr>
nnoremap   fzh          :FZF ~<cr>
nnoremap   fzr          :FZF /<cr>

" CD location
nnoremap   g.          :edit! .<cr>
nnoremap   g=          mggg=G"g
nnoremap   g,	       /><CR>ci<
nnoremap   g0	       /)<CR>ci(
nnoremap   g0	       :bn<CR>
nnoremap   g9	       /)<CR>ci(
nnoremap   g9	       :bp<cr>
nnoremap   gm          `
nnoremap   g[          /]<CR>ci[
nnoremap   g]          /]<CR>ci[
execute "nnoremap   gdf         :edit " . g:dotfile . "<cr>"
nnoremap   gdl         :edit ~/Downloads<cr>
nnoremap   gb          G
vnoremap   gb          G
nnoremap   ge          e
nnoremap   gh          :noh<cr>
nnoremap   gi          ==
nnoremap   gJ          J
" nnoremap   gk	       :w<CR>>:<UP><CR>
vnoremap   Gn          :normal!<space>
nnoremap   Gn          :normal!<space>
nnoremap   gnl         :call NavigateLeftHanded()<cr>
" nnoremap   go          :browse oldfiles<cr>
nnoremap   go          :call append(line('$'),'')<cr>:call append(line('$'),"")<cr>GG
nnoremap   gp          p
nnoremap   gP          P
nnoremap   gS          :Startify<cr>
nnoremap   gt          <C-]>ww
nnoremap   g{	       /}<CR>ci{

nnoremap   G            <Nop>
" nnoremap   GC          :call GitAddCommitPush()<cr>
nnoremap   GG          G
nnoremap   GL	       :G log<cr>
nnoremap   G.          :G add .<cr>
nnoremap   Gav         :G add % \| :G commit -v<Cr>
nnoremap   Ga5         :w<cr>:G add %<cr>
nnoremap   Gc          :Gcommit -m ""<Left>
" nnoremap   G5          :w<cr>:G add %<cr>:Gcommit -m ""<Left>
nnoremap   G5          :G add %<cr>:Gcommit -m ""<Left>
nnoremap   Gd	       :Gdiff<cr>
" nnoremap   Gh	       :Gpush<cr>:Gstatus<cr>
" nnoremap   Gl	       :Gpull<cr>:Gstatus<cr>
nnoremap   Gh          :Dispatch! git push<cr>
nnoremap   Gl          :Dispatch! git pull<cr>
nnoremap   Gy          :Goyo 120x100%<cr> <bar> :set number<cr>

" nnoremap   gbh         :bp<cr>
" nnoremap   gbl         :bn<cr>
" nnoremap   gbd         :bd<cr>
nnoremap   Gr          :Grep \<<C-r><C-w>\><CR>
nnoremap   Gs	       :Gstatus<cr>

map        Gj          <Plug>(GitGutterNextHunk)zz
map        Gk          <Plug>(GitGutterPrevHunk)zz

" h map
" nnoremap   H            <Nop>
" nnoremap   HH           H

" i map
nnoremap   I            <Nop>
nnoremap   II           I
nnoremap   Ia           mmgg=G`m

" m map
nnoremap   Ms           m
nnoremap   Ml           "
" nnoremap   Ms           :marks<cr>
nnoremap   MM           `
nnoremap   m            `

" n map
vnoremap   N           "nY<Esc>mN:e ~/df/NOTES.md<CR>gg"nP:w!<CR>
 
" p map
" nnoremap   p            p`[v`]==
nnoremap   gp           p
" nnoremap   P            P`[v`]==
nnoremap   gP           P
nnoremap   p           o<Esc>p==
vnoremap   p           "_dP
vnoremap   gp          p 
nnoremap   P           O<Esc>P==

" q map
nnoremap   Q            <Nop>
nnoremap   QQ 	        :quit!<cr>
nnoremap   QA 	        :qall!<cr>
" nnoremap   qq           echo "macro"
nnoremap   q            :call QuitIfNotLastWindow()<cr>
vnoremap   q            mm:norm@q<cr>`m

" s map
nnoremap     s2         :vsplit<cr>
nnoremap     s3         :vsplit<cr> \| :vsplit<cr>
" nnoremap     s5         :w<cr>:source %<cr>
inoremap   <C-e>        <C-o>:<Plug>(easymotion-overwin-f2)<CR>
nnoremap   S            <Nop>
nnoremap   SF           :Startify<cr>
nnoremap   s1           :!
nnoremap    SS          :w<cr>:source %<cr>:noh<CR>
"nnoremap   SS           S
nnoremap   Sp           :call PrepWindows()<cr>
" add below to last line with visodu for passwordless sudo
" ply     ALL=(ALL) NOPASSWD:ALL  
nnoremap   SW           :w !sudo tee %<cr>
"
" nnoremap   <C-s>        <c-w><c-w>

nnoremap <silent> Slg   :tabnew<cr>:set nonumber<cr>:terminal lazygit<cr>i
nnoremap <silent> Sc    :vsplit<cr>:set nonumber<cr>:terminal \%userprofile\%\\Downloads\\CentOS8\\CentOS8.exe<cr>isu centos<cr>
nnoremap   s            <Nop>
nnoremap   s=           <C-w>=
nnoremap   sH 	        :vertical resize -5<cr>
nnoremap   sJ 	        :resize -5<cr>
nnoremap   sK 	        :resize +5<cr>
nnoremap   sL 	        :vertical resize +5<cr>
nnoremap   sN           :new<cr>
nnoremap   sS           :split<cr>
nnoremap   sab          :normal V%<cr><down>
nnoremap   sav          :source /mnt/nvm/users/ply/df/alt-navigation.vim<cr>
nnoremap   sb           :normal V%<cr>
nnoremap   sT           :silent !tmux setenv PANENAME_S1_P1 nvim<cr>

" nnoremap   sbd          :bdelete!<cr>  " sb - mapped to select block
nnoremap   sdb          :bdelete<CR>
nnoremap   sdg          :diffget<CR>
nnoremap   sdj          ]czz
nnoremap   sdk          [czz
nnoremap   sdo          :diffoff<CR>
nnoremap   sdp          :diffput<CR>
nnoremap   sdt          :diffthis<CR>
nnoremap   sdu          :diffupdate<CR>
nnoremap   sdw          :windo diffthis<CR>
" nnoremap   sh           <C-w>h
nnoremap   s<Left>      <C-w>h
" nnoremap   sj           <C-w>j
nnoremap   s<Down>      <C-w>j
" nnoremap   sk           <C-w>k
nnoremap   s<Up>        <C-w>k
" nnoremap   sl           <C-w>l
nnoremap   s<Right>     <C-w>l
nnoremap   sh           :bprev<cr>
nnoremap   sl           :bnext<cr>
nnoremap   sn           :vnew<cr>
nnoremap   so           <C-w>o
nnoremap   sip          vip
nnoremap   sp           vap
nnoremap   sq           <C-w><C-w>q
nnoremap   sr           :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
nnoremap   ss           <C-w>w
nnoremap   sv           :vsplit<cr>
nnoremap   <silent>     sV           :silent !start vlc  --width=80 --video-x=1199 --video-y=1 --no-video-deco --no-embedded-video --video-on-top<cr>
nnoremap   sth          :tabp<cr>
nnoremap   stl          :tabn<cr>
nnoremap   svd          :vertical diffsplit<Space>
nnoremap   svn          :new<cr>
nnoremap   sw           *
nnoremap   sz           :ZoomToggle<cr>
vnoremap   sdg          :diffget<CR>
vnoremap   sdp          :diffput<CR>

" Hilights recently pasted and indenting recent pasted
nnoremap   si          `[v`]==
" nnoremap   sp          `[v`]
nnoremap   s,          `[v`]<<
nnoremap   s.          `[v`]>>

" t map
nnoremap   tb          :TagbarToggle<cr>
nnoremap   t           *<C-]>wwzz
nnoremap   tt          *<C-]>wwzz
nnoremap   tl          #*:vsp<cr>:exec("tag ".expand("<cword>"))<cr>ww
nnoremap   tj          #*:sp <cr>:exec("tag ".expand("<cword>"))<cr>ww
" nnoremap   tcl         :silent !\%userprofile\%\\df\\bin\\ctags -R --language-force=java -f \%userprofile\%\\df\\tags.java C:\\sandbox\\*.bsh<cr>
" nnoremap   tcl          !\%userprofile\%\\df\\bin\\ctags -R --language-force=java -f \%userprofile\%\\df\\tags.java C:\\sandbox\\*.bsh<cr>
execute "nnoremap   tcl          !\%userprofile\%\\" . g:dotfile . "\\bin\\ctags -R -f \%userprofile\%\\" . g:dotfile . "\\tags.java C:\\sandbox<cr>"
nnoremap   tc.         :!.\bin\ctags --recurse=yes --append<cr>
nnoremap   TT          zt3<C-y>
nnoremap   TS          :call Thesaurus()<CR>
nnoremap   To          zt <bar> let offset = string(float2nr(winheight('%') * g:center_screen_offset)) <bar> echo offset 
nnoremap   Tn          :tabnew<cr>
nnoremap   Tl          :tabnext<cr>
nnoremap   Th          :tabprev<cr>
nnoremap   Tc          :tabclose<cr>

" v map
nnoremap   <c-v>       p
inoremap   <c-v>       <c-r>+

" y map
nnoremap   Y            <Nop>
nnoremap   YY           yy
nnoremap   Yt           yy'yp
nnoremap   Yy           yy'mp    " copy from here
nnoremap   Yh           my \| echo "Copy" 
" nnoremap   yp           :normal! my \| vap \| :normal yy`y<cr>
nmap   yc           yygp<Up>gcc<Down>
nnoremap   yp           yyp
nnoremap   yk           <Up>yy
nnoremap   yj           <Down>yy<Up>

" u map
inoremap   UU          <Esc>viwUA

" x map
nnoremap   X           ZZ
inoremap   XX          <Esc>ZZ

" z map
" nnoremap   Z            <Nop>
nnoremap   Z            :call ZZ()<cr>
" nnoremap   Z            zz

" C- A- M- mappings {{{
"
"paste from buffer command/insert mode
cnoremap   <M-v>       <C-r>*
cnoremap   <M-j>       <Down>
cnoremap   <M-k>       <Up>
inoremap   <M-v>       <C-r>+

" inoremap   <C-v>       <C-r>*
inoremap   jk          <Esc>
inoremap   kk          <Esc>
inoremap   kl          <Esc>
"vnoremap   <C-c>       "+y
"vnoremap   <C-c>       "+y
" C-Space (ctrl-space)
inoremap  <C-BS>       <C-w>
nnoremap  <C-BS>       bdaW
inoremap  <M-j>        <C-n>
inoremap  <M-k>        <C-p>
inoremap  <M-h>        <C-k>
inoremap  <M-l>        <C-k>

nnoremap   <Down>      <C-e>j
" nnoremap   <Up>        <C-y>k
nnoremap   g<Down>     <Down>
" nnoremap   g<Up>       <Up>
nnoremap   g<Left>     <Left>
nnoremap   g<Right>    <Right>

" nnoremap   <M-h>       <C-w>h
" nnoremap   <M-j>       <C-w>j
" nnoremap   <M-k>       <C-w>k
" nnoremap   <M-l>       <C-w>l
" nnoremap   H           <C-o>
" nnoremap   L           <C-i>
" nnoremap     <C-i>     <C-o>
" nnoremap     <C-o>     <C-i>

nnoremap   +                  J
vnoremap   +                  J
" nnoremap   <A-S> 	          :new<cr>
nnoremap   <A-a> 	          za
" nnoremap   <A-f> 	          vip:fold<cr>
" nnoremap   <A-h> 	          <C-w>h
" nnoremap   <A-l> 	          <C-w>l
" nnoremap   <A-s> 	          :vnew<cr>
" nnoremap   <C-h> 	          <C-w>h
" nnoremap   <C-k>              K
" nnoremap   <C-h> 	          :vertical resize -5<cr>
" nnoremap   <C-j> 	          :resize -5<cr>
" nnoremap   <C-l> 	          :vertical resize +5<cr>
" nnoremap   <C-k> 	          :resize +5<cr>

nnoremap <C-3>      :buffer #<cr>
inoremap <A-n>      <C-n>
nnoremap <A-=>      gg=G<C-o><C-o>
" mappying to copy text to current cursor location
" mappying to copy text to current cursor location
" nnoremap <A-i>      :tabp<cr>
" nnoremap <A-o>      :tabn<cr>
nnoremap <A-i>      <C-o>zz
nnoremap <A-o>      <C-i>zz
nnoremap <A-c>      :tabe<cr>
nnoremap <A-9>      :tabp<cr>
nnoremap <A-0>      :tabn<cr>
nnoremap <A-1>      1gT
nnoremap <A-2>      2gT
nnoremap <A-3>      3gT
nnoremap <A-4>      4gT
nnoremap <A-5>      5gT

" Re-run command on right split. Switch windows and press {UP} {Enter}, then switch back

inoremap <M-r>                <Esc>:w<cr><C-w>li<Up><cr><c-\><C-n><C-w>ha
nnoremap <M-r>                <Esc>:w<cr><C-w>li<Up><cr><c-\><C-n><C-w>h
nnoremap gr                   <Esc>:w<cr><C-w>li<Up><cr><c-\><C-n><C-w>h

inoremap <M-w>                <Esc>:w<cr>
nnoremap <M-w>                :w<cr>
nnoremap <M-space>            :echo m-space<cr>

"}}}

" nnoremap {{{
"nnoremap   H                  :noh<cr>
" nnoremap   K                  :<C-u>call search('^.\+', 'b')<cr>{jzz
" nnoremap   K                  :call search('^.\+', 'b')<cr>{jzz
" nnoremap   J                  }jzz
" nnoremap   <silent> J                  :call UpperJ()<CR>
" nnoremap   <silent> <PageDown>         :call SimulateScroll()<CR>

" nnoremap   <silent> K                  :call UpperK()<CR>
"nnoremap   K                 
"nnoremap   M                  :call cursor(0, len(getline('.'))/2)<cr>
nnoremap   cw	              ciw
nnoremap   dw	              diw
" nnoremap   gp	              <C-o>]p
" nnoremap   gp                 :vsplit<cr>:set nonumber<cr>:terminal powershell -executionpolicy bypass<cr>i
nnoremap   gu                 :vsplit<cr>:set nonumber<cr>:terminal ubuntu1804<cr>i

"}}}

" vnoremap {{{
vnoremap   H                  ^
vnoremap   L                  $
" vnoremap   J                  }k
vnoremap   M                  :call cursor(0, len(getline('.'))/2)<cr>
vnoremap   K                  {j
vnoremap   s  :sort<cr>
vnoremap   O  vip
"}}}

nnoremap ;s         <c-\><c-n><c-w><c-w>

" Terminal mappings {{{
if has('nvim')
    tnoremap <C-w><C-w> <c-\><c-n><c-w><c-w>
    tnoremap <C-e>      <c-\><c-n>
    tnoremap <C-s>      <c-\><c-n><c-w><c-w>
    tnoremap <M-s>      <c-\><c-n><c-w><c-w>
    tnoremap ;s         <c-\><c-n><c-w><c-w>
    tnoremap ;o         <c-\><c-n><c-w>oi
    tnoremap <M-e>      <c-\><c-n>
endif
"}}}

" functions {{{

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

" RunScript: Saves file, then runs script base on extension of file, mapped to <Enter> 
function! RunScript()
    let extension = expand('%:e')
    let filename  = expand('%:t')
    " echo "filename: " . filename . " extension: " . extension
    if extension == "ahk"
        write
        !start \%userprofile\%\\df\\bin\\AutoHotkey %
        return
    endif
    if extension == "bat"
        write
        !%
        return
    endif
    if extension == "c"
        write
        !gcc % && ./a.out
        return
    endif
    if extension == "js"
        write
        !node %
        return
    endif
    if extension == "pl"
        write
        !perl %
        return
    endif
    if extension == "py"
        write
        !python %
        return
    endif
    if extension == "ps1"
        write
        !powershell -file %
        return
    endif
    if extension == "sh"
        write
        !bash %
        return
    endif
    if extension == "yaml" || extension == "yml"
        normal! mmgg=G`m
        write
        " call search('runscript:')
        " call search('\s')
        " call search('\S')
        " execute "normal! y$o\<Esc>p"
        execute "silent !echo clear > /tmp/run_script.sh"
        execute "silent !echo cd " . expand('%:p:h') . ">> /tmp/run_script.sh"
        execute "silent !echo 'echo DATE: `date` LOG: " . expand('%:p:h') . "/run_script.sh.log \| tee -a run_script.sh.log' >> /tmp/run_script.sh"
        execute "silent !echo unbuffer ansible-playbook " . expand('%:t') . ' \| sed -e \"s/skipped=0\\s*//\" -e \"s/rescued=0\\s*//\" -e \"s/ignored=0\\s*//\" \| tee -a run_script.sh.log >> /tmp/run_script.sh'
        " execute "silent !echo echo LOG [" . expand('%:p:h') . "/run_script.sh.log] >> /tmp/run_script.sh"
        execute "silent !echo 'echo >> run_script.sh.log' >> /tmp/run_script.sh"
        if exists('$TMUX') " running inside TMUX
            " echo "inside tmux"
            " !tmux set-option remain-on-exit on
            " !tmux split  -h "bash /tmp/run_script.sh"
            " !tmux send-keys -t {next} clear\; bash\ /tmp/run_script.sh C-m
            silent !tmux send-keys -t {next} time\ bash \ /tmp/run_script.sh C-m
            " !tmux set-option remain-on-exit off
            return
        else
            vsplit
            set nonumber
            vertical resize 115
            term bash /tmp/run_script.sh
            normal! \<c-w>\<Left>
            return
        endif
    endif
    if filename == "tmux.conf.symlink"
        write
        silent !tmux source-file %
        return
    endif
    echo "RunScript: " . filename . " not supportted."
    " if filename == "vimrc"
    "     write
    "     source %
    "     echo filename . " saved and sourced."
    "     " return
    " endif
endfunction

nnoremap <Space><Enter> :call RunScript()<cr>

function! DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call DiffWithSaved()

function! SaveSess()
    execute 'call mkdir(%:p:h/.vim)'
    execute 'mksession! %:p:h/nvim/session.vim'
endfunction

function! RestoreSess()
    execute 'so %:p:h/nvim/session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endfunction

function! QuitIfNotLastWindow()
    if winnr('$') != 1
        execute ":q!"
        echo "Window closed with 'q'."
    else
        echo "Last window, quit with QQ."
    endif
endfunction

"<== Zoom / Restore window. ===
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle 	call s:ZoomToggle()
" nnoremap <silent><A-z>  :ZoomToggle<cr>
"<=== Zoom / Restore window. ===

"}}}  zm to fold

" autocmd {{{
autocmd BufEnter *.bsh :set filetype=java
autocmd BufEnter *.bsh :set ff=dos
autocmd VimLeave * call SaveSess()
autocmd BufEnter term://* startinsert
" autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd FileType java set tags=~/df/tags
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" autocmd VimEnter * call RestoreSess()
" au FileType netrw hi CursorLine gui=underline
" au FileType netrw au BufEnter <buffer> map h -
" au FileType netrw au BufEnter <buffer> map l <Enter>
" au FileType netrw au BufEnter <buffer> map j <Down>
" au FileType netrw au BufEnter <buffer> map k <Up>
" au FileType netrw au BufEnter <buffer> map w p
" au FileType netrw au BufEnter <buffer> hi ActiveWindow        guibg=white
" au FileType netrw au BufLeave <buffer> hi clear CursorLine
"}}}

" Hilights {{{
hi EasyMotionTarget        ctermbg=none ctermfg=green   gui=bold guifg=purple
hi EasyMotionTarget        ctermbg=none ctermfg=green            guifg=purple     guibg=black
hi EasyMotionTarget2First  cterm=bold   ctermfg=40      gui=bold guifg=#7fbf00 "  guibg=whte purple inverse
hi EasyMotionTarget2First  cterm=bold   ctermfg=40      gui=bold guifg=Cyan    " purple inverse
hi EasyMotionTarget2Second cterm=bold   ctermfg=40      gui=bold guifg=#7fbf00 " purple inverse

if has('nvim')
    set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endif
"}}}

" host specific code {{{
let hostname = substitute(system('hostname'), '\n', '', '')

"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plug.vim bmpl {{{
if !exists('g:loaded_plug')  " Only load if it hasn't been loaded.
    if filereadable(expand(g:plug_vim_path))
        execute "source " . g:plug_vim_path
        call plug#begin(g:plug_vim_dir_path)
    elseif filereadable('/mnt/nvm/users/ply/df/nvim/plug.vim')
        source /mnt/nvm/users/ply/df/nvim/plug.vim
        call plug#begin('/mnt/nvm/users/ply/df/nvim/plugged')
    elseif filereadable('/nvm/users/ply/df/nvim/plug.vim')  " rvl-pv-vault
        execute "source /nvm/users/ply/df/nvim/plug.vim"
        call plug#begin("/nvm/users/ply/df/nvim/plugged")
    endif
    if hostname == "CAR-LT-C50626" || hostname == "Dell-7400"   "  Work Setup. configured to be in light mode, then inverted.
        " echom "Line 1064: inside g:load_plug hostname == CAR-LT-C50626"
        Plug 'easymotion/vim-easymotion'
        Plug 'morhetz/gruvbox'
        Plug 'machakann/vim-highlightedyank'
        Plug 'tpope/vim-commentary'
        Plug 'michaeljsmith/vim-indent-object'      " https://github.com/michaeljsmith/vim-indent-object
        Plug 'airblade/vim-gitgutter'
        " Plug 'vim-scripts/AutoComplPop'  " https://www.youtube.com/watch?v=2f8h45YR494
        Plug 'tpope/vim-fugitive'
        Plug 'fudesign2008/websearch.vim' " vnoremap gs
        Plug 'mhinz/vim-startify'
        Plug 'tpope/vim-dispatch'          " Gl/Gh git pull/push are dispatched so no waiting
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
        Plug 'antoinemadec/FixCursorHold.nvim' " needed for fern
        Plug 'lambdalisue/fern.vim'            " faster nerdtree
        " Plug 'craigemery/vim-autotag'
        " Plug 'yegappan/bufselect'
        Plug 'bling/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        " Plug 'honza/vim-snippets'
        " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        " Plug 'davidhalter/jedi'
        Plug 'SirVer/ultisnips'
        " Plug 'scrooloose/nerdtree'
        " Plug 'neovim/nvim-lspconfig'  " native neovim lsp
        " Plug 'nvim-lua/completion-nvim'  " native neovim lsp
        Plug 'jremmen/vim-ripgrep'
        " Plug 'osyo-manga/vim-brightest'
        " Plug 'prabirshrestha/vim-lsp'
        " Plug 'mattn/vim-lsp-settings'
        " Plug 'ncm2/ncm2-vim-lsp'
        " Plug 'ncm2/ncm2'
        " Plug 'roxma/nvim-yarp'
        " Plug 'https://github.com/vim-scripts/scrollfix'
        Plug 'junegunn/limelight.vim'   " only highlight focus
        Plug 'junegunn/goyo.vim'        " just text
        " Plug 'severin-lemaignan/vim-minimap'
        " Plug 'psliwka/vim-smoothie'
        Plug 'jeetsukumaran/vim-indentwise'  " https://github.com/jeetsukumaran/vim-indentwise
        " Plug 'https://github.com/neoclide/coc-snippets'
        " --- telescope ---
        Plug 'nvim-lua/popup.nvim'
        Plug 'nvim-lua/plenary.nvim'
        Plug 'http://github.com/nvim-telescope/telescope.nvim'
        "
        " https://github.com/phenomenes/ansible-snippets
        Plug 'phenomenes/ansible-snippets'
        " --- telescope ---
        if has('win32') || has('win64')
            " Plug 'valloric/youcompleteme'
            echom "line 1125:  windows platform"
            Plug 'neoclide/coc.nvim', {'branch': 'release'}
        else
            echom "vimrc line 1128: non windows"
            Plug 'neoclide/coc.nvim', {'branch': 'release' }      " stable version
            " Plug 'TaDaa/vimade'
            Plug 'dracula/vim'
        endif
        " Plug 'grvcoelho/vim-javascript-snippets'
        " BM
    else
        echom "vimrc line 1136: outside g:load_plug hostname == CAR-LT-C50626"
        Plug 'easymotion/vim-easymotion'
        Plug 'morhetz/gruvbox'
        Plug 'machakann/vim-highlightedyank'
        Plug 'tpope/vim-commentary'
        Plug 'michaeljsmith/vim-indent-object'      " https://github.com/michaeljsmith/vim-indent-object
        Plug 'airblade/vim-gitgutter'
        Plug 'vim-scripts/AutoComplPop'  " https://www.youtube.com/watch?v=2f8h45YR494
        Plug 'tpope/vim-fugitive'
        Plug 'mhinz/vim-startify'
        Plug 'tpope/vim-dispatch'
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
        Plug 'antoinemadec/FixCursorHold.nvim' " needed for fern
        Plug 'lambdalisue/fern.vim'            " faster nerdtree
        Plug 'honza/vim-snippets'
        " Plug 'neoclide/coc.nvim', {'branch': 'release' }      " stable version
        Plug 'bling/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        " Plug 'https://github.com/vim-scripts/scrollfix'
        " Plug 'bling/vim-airline'
        " Plug 'vim-airline/vim-airline-themes'
        " Plug 'kien/ctrlp.vim'                       " Fuzzy file finder / map to F
        " Plug 'scrooloose/nerdtree'
        " Plug 'yuttie/comfortable-motion.vim'        " Physic Motion
        " Plug 'vim-scripts/matchit.zip'
        " Plug 'vim-scripts/svn-diff.vim'
        " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        " Plug 'zchee/deoplete-jedi'
        " Plug 'jiangmiao/auto-pairs'
        " Plug 'machakann/vim-highlightedyank'
        " Plug 'MattesGroeger/vim-bookmarks'          " https://vimawesome.com/plugin/vim-bookmarks
        " Plug 'tpope/vim-vinegar'
        " Plug 'honza/vim-snippets'
        " Plug 'beloglazov/vim-online-thesaurus'
        " Plug 'mhinz/vim-startify'
        " Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
        Plug 'junegunn/goyo.vim'        " just text
        Plug 'junegunn/limelight.vim'   " only highlight focus
        " Plug 'tpope/vim-sensible'
        " Plug 'rking/ag.vim'
        " Plug 'tpope/vim-surround'
        " Plug 'scrooloose/syntastic'
        " Plug 'tpope/vim-repeat'
        " Plug 'jceb/vim-orgmode'
        " Plug 'reedes/vim-pencil'
        " Plug 'terryma/vim-smooth-scroll'
        " Plug 'fudesign2008/websearch.vim'
        " Plug 'morhetz/gruvbox'
        " Plug 'neoclide/coc.nvim'     " new completion
        " Plug 'https://github.com/vimpostor/vim-tpipeline'
        "
        Plug 'christoomey/vim-tmux-navigator'
        " Plug 'TaDaa/vimade'
    endif
    call plug#end()
endif

" airline settings
let g:airline#extensions#tabline#formatter    = 'default'
let g:airline#extensions#tabline#left_sep     = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline_theme='sol'  " light
" let g:airline_theme='light'  " light
let g:airline_theme='minimalist' " dark
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:deoplete#enable_at_startup = 1
hi HighlightedyankRegion cterm=reverse gui=reverse
"nnoremap     <Space><Space>  :call QuaterCenter()<CR>
" nnoremap     <Enter>         :call ScrollFix()<CR>
" nnoremap     s1              <Plug>(easymotion-overwin-f)
nnoremap     <Space>C        :let g:screen_offset=!g:screen_offset<CR>:echo "g:screen_offset: " . string(g:screen_offset)<CR>
nnoremap     <Space>ZZ       :Goyo <bar> Goyo 100%x100% <bar> let g:zen_mode=!g:zen_mode <bar> call GuiWindowFullScreen(1) <bar> echom "g:zen_mode: " . g:zen_mode<CR>
nnoremap     <Space>ZX       :Goyo <bar> echom "g:zen_mode: " . g:zen_mode<CR>
nnoremap     <Space>LL       :Limelight!!<CR>
nnoremap     <Space>Lg       :let g:limelight_conceal_ctermfg="gray"<CR>
nnoremap     <Space>N        :set nonumber!<CR>
nnoremap     <Space>W        :set nowrap!<CR>

nnoremap     <silent> ,<Space>  :silent !start \%userprofile\%\\df\\bin\\AutoHotkey "\%userprofile\%\\df\\2third1080p.ahk"<cr>
"map          <Space>         <Plug>(easymotion-overwin-f2)
map          <Space>         :call EasyMotion#OverwinF(2)<cr>
nnoremap     <Space><Space>  /
vnoremap     <Space><Space>  /
nnoremap     <Space><BS>  ?
vnoremap     <Space><BS>  ?

nnoremap     <BS>          `` \| :call ZZ()<cr>

"map          vai         vaI

"}}}

" New things to try

"\<<C-r><C-w>\> :CocInstall coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Notes for line("below arguments"):
" $       the last line in the current buffer                 
" 'x      position of mark x (if the mark is not set, 0 is returned)                                           
" w0      first line visible in current window                
" w$      last line visible in current window                 
" v       In Visual mode: the start of the Visual area (the   
"         cursor is the end).  When not in Visual mode        
"         returns the cursor position.  Differs from '< in    
"         that it's updated right away.

" nnoremap ,oc          :r !python \%userprofile\%\\df\\ocr.py<CR>:%s//'/g<CR>

nnoremap          gq  q
nnoremap          ,of :%s//'/g
execute "nnoremap          ,oc :r !python \%userprofile\%\\" . g:dotfile . "\\ocr.py<CR>:%s//'/g<CR>"

augroup CursorLine  " only show on ActiveWindow
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

augroup ChangeLineColor
    au!
    au InsertEnter * execute "highlight cursorline ctermbg=" . g:CursorLineInsertCtermBg . " guibg=" . g:CursorLineInsertGuiBg . " ctermfg=white guifg=white"
    au InsertLeave * execute "highlight cursorline ctermbg=" . g:CursorLineNormalCtermBg . " guibg=" . g:CursorLineNormalGuiBg . " ctermfg=white guifg=white"
augroup END

set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

let g:CursorLineNormalGuiBg="darkblue"
let g:CursorLineInsertGuiBg="darkred"
let g:CursorLineNormalCtermBg="darkblue"
let g:CursorLineInsertCtermBg="darkred"

" hi cursorline                     ctermfg=white ctermbg=darkblue             guifg=white guibg=blue
"
execute "highlight cursorline ctermbg=" . g:CursorLineNormalCtermBg . " guibg=" . g:CursorLineNormalGuiBg . " ctermfg=white guifg=white"
" hi cursor           cterm=reverse ctermfg=black ctermbg=none     gui=reverse guifg=white guibg=blue
hi cursor             ctermfg=black                  gui=reverse guifg=white guibg=blue

nnoremap dK        md<Up>dd`d
nnoremap dJ        md<Down>dd`d

nnoremap <M-h>        [[
nnoremap <M-l>        ]]
nnoremap dJ        md<Down>dd`d

" let g:gruvbox_invert_selection='0'

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:alt_navigation="/tmp/.df/alt-navigation.vim"
if filereadable(expand(g:alt_navigation))
    execute "source " . g:alt_navigation
endif

augroup ResizeWindowOnVimResized
    autocmd!
    autocmd VimResized * wincmd =
augroup END

nnoremap          mc    :messages clear<cr>
nnoremap          ms    :messages<cr>
nnoremap          <a-c> :messages clear<cr>
" nnoremap          <a-s> :messages<cr>
nnoremap          <a-s> <c-w><c-w>

set background=dark

function! SuperTab()
    let l:part = strpart(getline('.'),col('.')-2,1)
    if (l:part =~ '^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction
imap <Tab> <C-R>=SuperTab()<CR>

colorscheme gruvbox
hi Normal ctermbg=none
" hi Visual                  cterm=bold     ctermfg=white                  gui=reverse     guifg=darkred guibg=white
" hi Visual                  cterm=bold     ctermfg=white                                  guifg=red     guibg=white
" hi Visual                  cterm=bold     ctermfg=white  ctermbg=214                       guifg=white   guibg=purple   " ctermcolor 5 - purple
hi Visual                  cterm=none      ctermfg=black  ctermbg=214                       guifg=white   guibg=purple   " ctermcolor 5 - purple
"hi ActiveWindow             guibg=black    ctermbg=234
" hi ActiveWindow             guibg=black    ctermbg=black
"hi InactiveWindow          guibg=black    ctermbg=black
hi Folded                  ctermfg=250    ctermbg=17      guifg=white    guibg=darkred
hi Search                  cterm=none     ctermfg=black   ctermbg=214
hi DiffAdd      ctermfg=darkgreen     ctermbg=black  guifg=darkgreen    guibg=gray80
hi DiffChange   ctermfg=208           ctermbg=black  guifg=darkorange4  guibg=gray80
hi DiffDelete   ctermfg=darkred       ctermbg=233    guifg=darkred      guibg=black
hi DiffText     ctermfg=darkyellow    ctermbg=black  guifg=yellow3      guibg=black
hi jsonCommentError guifg=#928374 guibg=black
hi Keyword          ctermfg=green ctermbg=black guibg=clear     guifg=green2
hi airline_tabsel   guibg=blue guifg=white ctermfg=black ctermbg=214

"
" ~/df/vimrc - END
