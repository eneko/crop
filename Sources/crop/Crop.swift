//
//  Crop.swift
//  crop
//
//  Created by Eneko Alonso on 2/17/18.
//

import AppKit
import Basic
import Utility

enum CropError: LocalizedError {
    case internalError(message: String)

    var errorDescription: String? {
        switch self {
        case let .internalError(message):
            return message
        }
    }
}

struct Crop {

    private let parser: ArgumentParser
    private let filenameOrURL: PositionalArgument<String>
    private let width: PositionalArgument<Int>
    private let height: PositionalArgument<Int>
    private let outputFilename: OptionArgument<String>

    init() {
        parser = ArgumentParser(usage: "<filename|url> <width> <height>", overview: "Resize and Crop images")
        filenameOrURL = parser.add(positional: "filename", kind: String.self, optional: false, usage: "Filename or URL")
        width = parser.add(positional: "width", kind: Int.self, optional: false, usage: "Output width in pixels")
        height = parser.add(positional: "height", kind: Int.self, optional: false, usage: "Output height in pixels")
        outputFilename = parser.add(option: "--output", shortName: "-o", kind: String.self, usage: "Output filename")
    }

    func run() {
        do {
            let arguments = Array(ProcessInfo.processInfo.arguments.dropFirst())
            let parsedArguments = try parser.parse(arguments)
            try processArguments(arguments: parsedArguments)
        }
        catch let error as ArgumentParserError {
            print(error.description)//, to: &stderrStream)
        }
        catch let error {
            print(error.localizedDescription)//, to: &stderrStream)
        }
    }

    private func processArguments(arguments: ArgumentParser.Result) throws {
        guard let filenameOrURL = arguments.get(filenameOrURL) else {
            throw CropError.internalError(message: "Missing filename or URL.")
        }
        guard let width = arguments.get(width) else {
            throw CropError.internalError(message: "Missing width parameter.")
        }
        guard let height = arguments.get(height) else {
            throw CropError.internalError(message: "Missing height parameter.")
        }
        let size = CGSize(width: width, height: height)
        let image = try loadImage(filenameOrURL: filenameOrURL)
        let resized = try processImage(image: image, size: size)
        let output = arguments.get(outputFilename) ?? filename(for: filenameOrURL, size: size)
        try saveImage(image: resized, outputFilename: output)
    }

    private func loadImage(filenameOrURL: String) throws -> NSImage {
        if let image = NSImage(contentsOfFile: filenameOrURL) {
            return image
        }
        if let url = URL(string: filenameOrURL), let image = NSImage(contentsOf: url) {
            return image
        }
        throw CropError.internalError(message: "Could not load image from: \(filenameOrURL)")
    }

    private func processImage(image: NSImage, size: CGSize) throws -> NSImage {
        print("🏙  Original image size: \(image.size.sizeString)")
        guard let resized = image.crop(to: size) else {
            throw CropError.internalError(message: "Failed to resize image.")
        }
        print("🏙  Resized image size: \(resized.size.sizeString)")
        return resized
    }

    private func filename(for filenameOrURL: String, size: CGSize) -> String {
        let url = URL(string: filenameOrURL) ?? URL(fileURLWithPath: filenameOrURL)
        let file = url.deletingPathExtension().lastPathComponent
        let ext = url.pathExtension.isEmpty ? "" : ".\(url.pathExtension)"
        return "\(file)_\(size.sizeString)\(ext)"
    }

    private func saveImage(image: NSImage, outputFilename: String) throws {
        guard let data = outputFilename.hasSuffix("png") ? image.pngRepresentation : image.jpgRepresentation else {
            throw CropError.internalError(message: "Failed to get image data.")
        }
        let url = URL(fileURLWithPath: outputFilename)
        try data.write(to: url)
        print("📁 Resized image saved to: \(url.path)")
    }

}

extension CGSize {
    var sizeString: String {
        return "\(Int(width))x\(Int(height))"
    }
}
