module Data.Array.Parallel.Lifted.Prim (
  PArray_Int#,
  lengthPA_Int#, emptyPA_Int#, replicatePA_Int#,
  upToP_Int#
) where

import Data.Array.Parallel.Unlifted

import GHC.Exts (Int#, Int(..))

newtype PArray_Int# = PInt# (UArr Int)

lengthPA_Int# :: PArray_Int# -> Int#
lengthPA_Int# (PInt# arr) = case lengthU arr of { I# n# -> n# }

emptyPA_Int# :: PArray_Int#
emptyPA_Int# = PInt# emptyU

replicatePA_Int# :: Int# -> Int# -> PArray_Int#
replicatePA_Int# n# i# = PInt# (replicateU (I# n#) (I# i#))

upToP_Int# :: Int# -> PArray_Int#
upToP_Int# n# = PInt# (enumFromToU 0 ((I# n#) -1))

