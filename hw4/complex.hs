import Prelude 

-- A C = (a, b) = (a, 0) + (0, b) 
--              = (a, 0) + (b, 0) x (0, 1) 
--              = a + bi
type C = (Float, Float)


-- complex addition; combine Re with Re and Im with Im 
cplus :: C -> C -> C
cplus (r1, i1)  (r2, i2) = (r1 + r2, i1 + i2)

-- multiply each term of the 1st C with each term of the 2nd C
cmult :: C -> C -> C
cmult (r1, i1) (r2, i2) = (re, im)
    where re = r1*r2 - i1*i2
          im = r1*i2 + i1*r2

-- square complex numbers, e.g., x^2 = cmult x x 
csqr :: C -> C
csqr x = cmult x x

-- 
csub :: C -> C -> C
csub (r1, i1) (r2, i2) = (re, im)
  where re = r1-r2
        im = i1-i2

-- complex division
cdiv :: C -> C -> C
cdiv (r1, i1) (r2, i2) = (denom $ r1*r2 + i1*i2, denom $ r2*i1 - r1*i2)
  where denom x = x / (r2*r2 + i2*i2)

ex :: C
ex = cdiv (0,3) (-1,-1)

-- complex modulus
-- essentially absolute value
-- |c| = |a + bi| = +sqrt(a^2 + b^2)
cmod :: C -> Float
cmod (r, i) = pos $ sqrt $ r*r + i*i 
  where pos x = if x < 0 then -x else x

modex :: Float
modex = cmod (1, -1)

conj :: C -> C
conj (r,i) = (r, -i)

-- solution (zero) to polynomial equation with no Real solution
-- poly^n: x^2 + 2x + 2
(.+.) :: C -> C -> C 
(.+.) = cplus

(.*.) :: C -> C -> C 
(.*.) = cmult

infixl 8 .+.
infixl 9 .*.

-- foo = a :+: b :+: d
--     = cplus (cplus a b) d

-- (cplus) a b y
interesting :: C
interesting = x .*. x .+. y .*. x .+. y 
  where x = ((-1), 1)
        y = (2, 0)
--         a = csqr x
--         b = cmult y x
--         d = cplus a b


-- P is for Polar coordinates
-- A P is a (mangitude, phase) where phase is an angle 
--    i.e., (modulus, angle)
type P = (Float, Float)

c_to_p :: C -> P
c_to_p (a,b) = (mod,angle)
  where mod   = cmod (a,b)
        angle = atan $ b / a 

p_to_c :: P -> C
p_to_c (mod,angle) = (a,b)
  where a = mod * (cos $ angle)
        b = mod * (sin $ angle)

pplus :: P -> P -> P
pplus (m1,a1) (m2,a2) = (m1+m2, a1+a2)
(..+) :: P -> P -> P
(..+) = pplus

pmult :: P -> P -> P
pmult (m1,a1) (m2,a2) = (m1*m2, a1+a2)
(..*) :: P -> P -> P
(..*) = pmult

pdiv :: P -> P -> P
pdiv (m1,m2) (a1,a2) = (m1/m2 , a1 - a2)

(../) :: P -> P -> P
(../) = pdiv

type CVec = [C]
scalar_mult :: C -> CVec -> CVec
scalar_mult c v = [c .*. x | x <- v]
