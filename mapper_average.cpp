#include <iostream>
#include <string>

int main(int argc, char ** argv)
{
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
                            double price = std::stod(field);
                            std::cout << price << std::endl;
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

