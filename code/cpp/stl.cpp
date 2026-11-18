// The Standard Template Library: containers and algorithms.
#include <algorithm>
#include <iostream>
#include <map>
#include <numeric>
#include <string>
#include <vector>

// A function template: works for any type T that supports + and /
template <typename T>
T mean(const std::vector<T>& x)
{
    return std::accumulate(x.begin(), x.end(), T{0}) / static_cast<T>(x.size());
}

int main()
{
    std::vector<double> loads = {12.6, 14.0, 13.2, 15.8, 11.9};
    std::sort(loads.begin(), loads.end());
    std::cout << "sorted:";
    for (double L : loads) std::cout << ' ' << L;
    std::cout << "\nmean = " << mean(loads) << " kN\n";

    auto big = std::count_if(loads.begin(), loads.end(), [](double L) { return L > 13.0; });
    std::cout << big << " loads exceed 13 kN\n";
    auto [mn, mx] = std::minmax_element(loads.begin(), loads.end());
    std::cout << "range: " << *mn << " to " << *mx << " kN\n";

    std::map<std::string, double> density = {
        {"steel", 7850}, {"aluminium", 2700}, {"water", 998}};
    density["copper"] = 8960;
    for (const auto& [name, rho] : density)        // maps are kept sorted by key
        std::cout << name << ": " << rho << " kg/m^3\n";
}
