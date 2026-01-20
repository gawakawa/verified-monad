module VerifiedMonad

public export
interface VerifiedMonad (m : Type -> Type) where
  pure : a -> m a
  (>>=) : m a -> (a -> m b) -> m b

  leftIdentity : (a : t) -> (f : t -> m u) -> pure a >>= f = f a
  rightIdentity : (ma : m t) -> ma >>= pure = ma
  associativity : (ma : m t) -> (f : t -> m u) -> (g : u -> m v)
               -> (ma >>= f) >>= g = ma >>= (\x => f x >>= g)

public export
VerifiedMonad Maybe where
  pure = Just

  Nothing >>= f = Nothing
  Just x  >>= f = f x

  leftIdentity a f = Refl

  rightIdentity Nothing  = Refl
  rightIdentity (Just x) = Refl

  associativity Nothing  f g = Refl
  associativity (Just x) f g = Refl
