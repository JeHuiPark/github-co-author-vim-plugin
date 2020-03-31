let s:message_prefix = 'Co-Authored-By: '

let s:fallback = 1
if exists("g:github_co_author_list_path")
  let s:fallback = 0
endif

augroup vim_autocomplte_co_auth
  autocmd FileType gitcommit inoremap <C-l> <C-R>=GetTeam()<CR>
augroup END

function! GetTeam()
  if s:fallback
    return s:message_prefix . ' name <email>'
  endif

  let records = readfile(expand(g:github_co_author_list_path))
  
  let mem = []

  for record in records
    if record =~ '^"'
      continue
    endif

    let cols = split(record)
    let usernameAndEmail = cols[1] . ' ' . cols[2]
    call add(mem, s:message_prefix . usernameAndEmail)
  endfor

  call complete(col('.'), mem)
  return ''
endfunction

