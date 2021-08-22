let s:message_prefix = 'Co-Authored-By: '

let s:fallback = 1
if exists("g:github_co_author_list_path")
  let s:fallback = 0
endif

augroup vim_autocomplte_co_auth
  autocmd FileType gitcommit inoremap <C-l> <C-R>=GitHubCoAuthor#GetTeam()<CR>
augroup END

function! GitHubCoAuthor#GetTeam()
  let records = GitHubCoAuthor#ReadRecord()

  let mem = []

  for record in records
    if record =~ '^"'
      continue
    endif

    call add(mem, s:message_prefix . record)
  endfor

  call complete(col('.'), mem)
  return ''
endfunction

function! GitHubCoAuthor#ReadRecord()
  if GitHubCoAuthor#HasLocal()
    return readfile(GitHubCoAuthor#LocalPath())
  endif

  if s:fallback
    return ['alias_section name <email>']
  endif

  return GitHubCoAuthor#GlobalRecord()
endfunction

function! GitHubCoAuthor#HasLocal()
  let systemCommand = '[ -f ' . GitHubCoAuthor#LocalPath() .  ' ] && echo 1 || echo 0'
  return system(systemCommand)
endfunction

function! GitHubCoAuthor#LocalPath()
  let localFilePath = system('echo `git rev-parse --show-toplevel`/.git_author')
  return substitute(localFilePath, '\n', '', '')
endfunction

function! GitHubCoAuthor#GlobalRecord()
  if s:fallback
    abort
  endif
  return readfile(expand(g:github_co_author_list_path))
endfunction

