// swift-tools-version: 6.0
import PackageDescription

let name: String = "libzip"
let version: String = "1.11.3"

let products: [Product] = [
    .library(
        name: name,
        targets: [name]
    )
]

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-nio-ssl.git", from: "2.30.0")
]

let targets: [Target] =
    [
        // TODO: SHARED_LIB_VERSIONNING
        .target(
            name: name,
            // dependencies: [
            //     // use CNIOBoringSSL instead of OpenSSL
            //     .product(name: "NIOSSL", package: "swift-nio-ssl")
            // ],
            path: "lib",
            exclude: [
                "zip_algorithm_bzip2.c", // BZip2
                "zip_algorithm_xz.c", // LibLZMA
                "zip_algorithm_zstd.c", // ZStandard
                // "zip_crypto_commoncrypto.c", // CommonCrypto
                "zip_crypto_win.c", // Windows Crypto
                "zip_crypto_gnutls.c", // GnuTLS
                "zip_crypto_openssl.c", // use BoringSSL instead
                "zip_crypto_mbedtls.c", // MbedTLS
                "zip_source_file_win32_ansi.c",
                "zip_random_win32.c",
                "zip_random_uwp.c",
                "zip_source_file_win32.c",
                "zip_source_file_win32_named.c",
                "zip_source_file_win32_utf16.c",
                "zip_source_file_win32_utf8.c",
                "CMakeLists.txt"
            ],
            publicHeadersPath: ".",
            cSettings: [
                .define("PACKAGE", to: "\"\(name)\""),
                .define("VERSION", to: "\"\(version)\""),
                // .define("USE_SWIFT_BORINGSSL"),
                .define("_DEBUG", to: "1", .when(configuration: .debug))
            ],
            linkerSettings: [
                .linkedFramework("Foundation"),
                .linkedFramework("CommonCrypto"),
                .linkedLibrary("z")
            ]
        )
    ]

let package = Package(
    name: "libzip",
    products: products,
    dependencies: dependencies,
    targets: targets,
    cLanguageStandard: CLanguageStandard.c11
)
