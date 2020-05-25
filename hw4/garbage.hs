type C = (Float, Float)

ex_a :: C
ex_a = c (-3) (-1)

ex_b :: C
ex_b = c 1 (-2)

ex_c :: C
ex_c = cmult ex_a ex_b
-- more random examples, some from book

-- Smart Constructor
c :: Float -> Float -> C
c r i = (r, i)


c1 :: C
c1 = c (-3) 1

c2 :: C
c2 = c 2 $ -4

oc1 :: C
oc1 = c 3 $ -1

oc2 :: C
oc2 = c 1 4


oc1poc2 :: C
oc1poc2 = c (-1) (-3)

oc1xoc2 :: C 
oc1xoc2 = c (-2) 14

-- a + a + a where a = c1 + c2
example = let a = cplus c1 c2 in
            let b = cplus a a in
              cplus b a 


