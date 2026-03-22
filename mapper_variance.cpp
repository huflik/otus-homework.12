#include <iostream>
#include <string>
#include <cmath>
#include <iomanip>

int main(int argc, char ** argv)
{
    if(argc < 2)
    {
        return 1;
    }
    
    double mean;
    try
    {
        mean = std::stod(argv[1]);
    }
    catch(...)
    {
        return 1;
    }
    
    std::string line;
    
    while(std::getline(std::cin, line))
    {
        try
        {
            int columnIndex = 0;
            std::string field;
            bool inQuotes = false;
            
            for(size_t i = 0; i <= line.size(); ++i)
            {
                char c = (i < line.size()) ? line[i] : ',';
                
                if(c == '"') {
                    inQuotes = !inQuotes;
                    field += c;
                }
                else if(c == ',' && !inQuotes) {
                    if(columnIndex == 9) {  
                        if(!field.empty() && field != "\"\"") {
                            try {
                                double price = std::stod(field);
                                double deviation = price - mean;
                                double squaredDeviation = deviation * deviation;
                                std::cout << std::setprecision(15) << squaredDeviation << std::endl;
                            } catch(...) {
                            }
                        }
                    }
                    field.clear();
                    columnIndex++;
                }
                else {
                    field += c;
                }
            }
        }
        catch(const std::exception& e) {
            continue;
        }
    }
    
    return 0;
}