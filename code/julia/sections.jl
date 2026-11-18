abstract type Section end

struct Rectangle <: Section     # <: means "is a subtype of"
    b::Float64
    h::Float64
end

struct Circle <: Section
    d::Float64
end

area(s::Rectangle) = s.b * s.h
area(s::Circle)    = π * s.d^2 / 4
second_moment(s::Rectangle) = s.b * s.h^3 / 12
second_moment(s::Circle)    = π * s.d^4 / 64

sections = [Rectangle(0.05, 0.10), Circle(0.08)]
for s in sections
    println(typeof(s), ": A = ", area(s), ", I = ", second_moment(s))
end
