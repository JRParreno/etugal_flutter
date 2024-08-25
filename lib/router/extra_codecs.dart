// import 'dart:convert';


// class MyExtraCodec extends Codec<Object?, Object?> {
//   /// Create a codec.
//   const MyExtraCodec();
//   @override
//   Converter<Object?, Object?> get decoder => const _MyExtraDecoder();

//   @override
//   Converter<Object?, Object?> get encoder => const _MyExtraEncoder();
// }

// class _MyExtraDecoder extends Converter<Object?, Object?> {
//   const _MyExtraDecoder();
//   @override
//   Object? convert(Object? input) {
//     if (input == null) {
//       return null;
//     }
//     final List<Object?> inputAsList = input as List<Object?>;
//     if (inputAsList[0] == 'BlogModel') {
//       return BlogModel.fromMap(inputAsList[1] as Map<String, dynamic>);
//     }

//     throw FormatException('Unable to parse input: $input');
//   }
// }

// class _MyExtraEncoder extends Converter<Object?, Object?> {
//   const _MyExtraEncoder();
//   @override
//   Object? convert(Object? input) {
//     if (input == null) {
//       return null;
//     }
//     switch (input) {
//       case BlogModel _:
//         return <Object?>['BlogModel', input.toMap()];
//       default:
//         throw FormatException('Cannot encode type ${input.runtimeType}');
//     }
//   }
// }
