-- >>> resh >>>
dofile("/Users/geprokhorov/Library/Application Support/resh/resh.lua")
rex.exec.start({ "/Users/geprokhorov/Library/Application Support/resh/resh", "service", "start" },
  { detach = true, stdout = false, stderr = false })
-- <<< resh <<<
