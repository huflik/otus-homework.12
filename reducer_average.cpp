#include <iostream>
#include <string>
#include <iomanip>

int main(int argc, char ** argv)
{
    size_t count = 0;
    double sum = 0.0;
    std::string line;
    
    while(std::getline(std::cin, line))
    {
        try
        {
            double price = std::stod(line);
            sum += price;
            count++;
        }
        catch(const std::exception& e) {
            continue;
        }
    }
    
    if(count > 0)
    {
        double mean = sum / count;
        std::cout << std::setprecision(15) << mean << std::endl;
    }
    else
    {
        std::cout << "0" << std::endl;
    }
    
    return 0;
}