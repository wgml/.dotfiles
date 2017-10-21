function! SourceHeaderJump()
  let withoutExt = expand('%:r')
  let extension = expand('%:e')
  let candidates = []

  if extension == "h"
    let candidates = [withoutExt.".C", withoutExt.".cpp", withoutExt.".cc"]

    if withoutExt =~# "/include/"
      let withoutExtSource = substitute(withoutExt, "/include/", "/src/", "")
      let candidates = candidates + [withoutExtSource.".C", withoutExtSource.".cpp", withoutExt.".cc"]
    endif

    if withoutExt =~# "Fwd$"
      let withoutFwd = strpart(withoutExt, 0, strlen(withoutExt)-3)
      let candidates = candidates + [withoutFwd.".h"]
    elseif withoutExt =~# "Impl$"
      let withoutImpl = strpart(withoutExt, 0, strlen(withoutExt)-4)
      let candidates = candidates + [withoutImpl.".h"]
    else
      let candidates = candidates + [withoutExt."Impl.h"]
    endif
  elseif extension == "C" || extension == "cpp" || extension == "cc"
    let candidates = [withoutExt.".h"]

    if withoutExt =~# "/src/"
      let withoutExtInclude = substitute(withoutExt, "/src/", "/include/", "")
      let candidates = candidates + [withoutExtInclude.".h"]
    endif
  endif

  for fileToOpen in candidates
    if filereadable(fileToOpen)
      let bnr = bufnr(fileToOpen)
      if bnr > 0
        silent execute 'buffer' bnr
      else
        silent execute 'edit' fileToOpen
      endif

      return
    endif
  endfor

  echo "None of the files [".join(candidates, ", ")."] exist"
endfunction
