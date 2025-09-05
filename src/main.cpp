#include <iostream>

#include <zlib.h>
#include <nlohmann/json.hpp>
#include <fmt/core.h>
#include <Eigen/Dense>
#include <boost/lexical_cast.hpp>

int main(void) {
    // Example usage of zlib
    const char* original = "Hello, zlib!";
    uLong original_length = strlen(original) + 1; // +1 for null terminator
    uLong compressed_length = compressBound(original_length);
    Bytef* compressed = (Bytef*)malloc(compressed_length);

    if (compress(compressed, &compressed_length, (const Bytef*)original, original_length) != Z_OK) {
        fprintf(stderr, "Compression failed\n");
        free(compressed);
        return EXIT_FAILURE;
    }

    fmt::print("Original: {}\n", original);
    fmt::print("Compressed length: {}\n", compressed_length);

    // Example usage of nlohmann_json
    nlohmann::json j;
    j["message"] = "Hello, JSON!";
    fmt::print("JSON: {}\n", j.dump());

    // Example usage of Eigen
    Eigen::Vector3d v(1.0, 2.0, 3.0);
    // fmt::print("Eigen Vector: {}\n", v.transpose());
    std::cout << "Eigen Vector: " << v.transpose() << std::endl;

    // Example usage of Boost
    // Note: Boost is not used in this example, but you can include Boost headers and use its features as needed.
    // For example, using Boost's lexical_cast
    std::string number_str = "42";
    try {
        int number = boost::lexical_cast<int>(number_str);
        fmt::print("Boost lexical_cast: {}\n", number);
    } catch (const boost::bad_lexical_cast& e) {
        fmt::print("Boost lexical_cast failed: {}\n", e.what());
    }

    free(compressed);
    return EXIT_SUCCESS;
}