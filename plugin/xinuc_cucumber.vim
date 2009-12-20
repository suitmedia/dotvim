function! Cucumber(args)
  if a:args == 'f'
    execute ':!xterm -e "cucumber %; read" &'
  elseif a:args == 'l'
    execute ':!xterm -e "cucumber %:'. line('.') .'; read" &'
  elseif a:args == 'o'
    execute ':!xterm -e "cucumber % -t @focus; read" &'
  elseif a:args == 'a'
    execute ':!xterm -e "AUTOFEATURE=true autospec" &'
  else
    execute ':!xterm -e "cucumber; read" &'
  endif
endfunction

command! -nargs=* -complete=file Cucumber call Cucumber(<q-args>)
