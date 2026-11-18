// Classes, inheritance and polymorphism: beam cross-sections.
#include <cmath>
#include <iostream>
#include <iomanip>
#include <memory>
#include <numbers>     // std::numbers::pi (C++20)
#include <string>
#include <vector>

class Section {                          // abstract base class
public:
    virtual ~Section() = default;
    virtual double area() const = 0;     // "= 0": every derived class must define it
    virtual double second_moment() const = 0;   // I about the horizontal axis
    virtual std::string name() const = 0;
};

class Rectangle : public Section {
public:
    Rectangle(double b, double h) : b_(b), h_(h) {}
    double area() const override { return b_ * h_; }
    double second_moment() const override { return b_ * h_ * h_ * h_ / 12.0; }
    std::string name() const override { return "rectangle"; }
private:
    double b_, h_;                       // width and height, m
};

class Circle : public Section {
public:
    explicit Circle(double d) : d_(d) {}
    double area() const override { return std::numbers::pi * d_ * d_ / 4.0; }
    double second_moment() const override { return std::numbers::pi * std::pow(d_, 4) / 64.0; }
    std::string name() const override { return "circle"; }
private:
    double d_;                           // diameter, m
};

class Tube : public Circle {             // a hollow circle IS-A circle, with a hole
public:
    Tube(double d_out, double d_in) : Circle(d_out), hole_(d_in) {}
    double area() const override { return Circle::area() - hole_.area(); }
    double second_moment() const override {
        return Circle::second_moment() - hole_.second_moment();
    }
    std::string name() const override { return "tube"; }
private:
    Circle hole_;
};

int main()
{
    std::vector<std::unique_ptr<Section>> sections;
    sections.push_back(std::make_unique<Rectangle>(0.05, 0.10));
    sections.push_back(std::make_unique<Circle>(0.08));
    sections.push_back(std::make_unique<Tube>(0.10, 0.09));

    std::cout << std::scientific << std::setprecision(3);
    for (const auto& s : sections)       // the right area() is chosen at run time
        std::cout << std::setw(10) << s->name()
                  << "  A = " << s->area() << " m^2"
                  << "  I = " << s->second_moment() << " m^4"
                  << "  I/A = " << s->second_moment() / s->area() << " m^2\n";
}
