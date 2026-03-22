#include <iostream>
#include <string>
#include <iomanip>

int main(int argc, char ** argv)
{
    size_t count = 0;
    double sumSquaredDeviations = 0.0;
    std::string line;
    
    while(std::getline(std::cin, line))
    {
        try
        {
            double squaredDeviation = std::stod(line);
            sumSquaredDeviations += squaredDeviation;
            count++;
        }
        catch(const std::exception& e) {
            continue;
        }
    }
    
    if(count > 1)  
    {
        double sampleVariance = sumSquaredDeviations / (count - 1);
        std::cout << std::setprecision(15) << sampleVariance << std::endl;
    }
    else if(count == 1)
    {
        std::cout << "0" << std::endl;
    }
    else
    {
        std::cout << "0" << std::endl;
    }
    
    return 0;
}