{-# LANGUAGE ParallelArrays #-}
{-# OPTIONS -fvectorise #-}
{-# OPTIONS -fno-spec-constr-count #-}
module QuickSortVect (quicksortPA) where

import Data.Array.Parallel.Prelude
import Data.Array.Parallel.Prelude.Double
import qualified Data.Array.Parallel.Prelude.Int as I

import qualified Prelude

quicksortPA:: PArray Double -> PArray Double 
quicksortPA xs = toPArrayP  (qsortVect' (fromPArrayP xs))

qsortVect':: [: Double :] -> [: Double :]
{-# NOINLINE qsortVect' #-}
qsortVect' xs | lengthP xs I.<=  1 = xs
              | otherwise =
  let p  = xs !: (lengthP xs `I.div` 2)
      ls = [:x | x <- xs, x < p:]
      gs = [:x | x <- xs, x > p:]

      ss = mapP qsortVect' [:ls, gs:]
 in
 (ss !: 0) +:+ [:x | x <- xs, x == p:] +:+ (ss !: 1)
