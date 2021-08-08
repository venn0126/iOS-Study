; ModuleID = '<swift-imported-modules>'
source_filename = "<swift-imported-modules>"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx11.0.0"

%swift.vwtable = type { i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i64, i64, i32, i32 }
%swift.type_metadata_record = type { i32 }
%swift.type = type { i64 }
%swift.refcounted = type { %swift.type*, i64 }
%T4main3CatV = type <{ %swift.function }>
%swift.function = type { i8*, %swift.refcounted* }
%"main.Cat.biBao.modify : () -> () with unmangled suffix ".Frame"" = type {}
%swift.opaque = type opaque
%swift.metadata_response = type { %swift.type*, i64 }

@"\01l_entry_point" = private constant { i32 } { i32 trunc (i64 sub (i64 ptrtoint (i32 (i32, i8**)* @main to i64), i64 ptrtoint ({ i32 }* @"\01l_entry_point" to i64)) to i32) }, section "__TEXT, __swift5_entry, regular, no_dead_strip", align 4
@"value witness table for main.Cat" = internal constant %swift.vwtable { i8* bitcast (%swift.opaque* ([24 x i8]*, [24 x i8]*, %swift.type*)* @"initializeBufferWithCopyOfBuffer value witness for main.Cat" to i8*), i8* bitcast (void (%swift.opaque*, %swift.type*)* @"destroy value witness for main.Cat" to i8*), i8* bitcast (%swift.opaque* (%swift.opaque*, %swift.opaque*, %swift.type*)* @"initializeWithCopy value witness for main.Cat" to i8*), i8* bitcast (%swift.opaque* (%swift.opaque*, %swift.opaque*, %swift.type*)* @"assignWithCopy value witness for main.Cat" to i8*), i8* bitcast (i8* (i8*, i8*, %swift.type*)* @__swift_memcpy16_8 to i8*), i8* bitcast (%swift.opaque* (%swift.opaque*, %swift.opaque*, %swift.type*)* @"assignWithTake value witness for main.Cat" to i8*), i8* bitcast (i32 (%swift.opaque*, i32, %swift.type*)* @"getEnumTagSinglePayload value witness for main.Cat" to i8*), i8* bitcast (void (%swift.opaque*, i32, i32, %swift.type*)* @"storeEnumTagSinglePayload value witness for main.Cat" to i8*), i64 16, i64 16, i32 65543, i32 2147483647 }, align 8
@0 = private constant [5 x i8] c"main\00"
@"module descriptor main" = linkonce_odr hidden constant <{ i32, i32, i32 }> <{ i32 0, i32 0, i32 trunc (i64 sub (i64 ptrtoint ([5 x i8]* @0 to i64), i64 ptrtoint (i32* getelementptr inbounds (<{ i32, i32, i32 }>, <{ i32, i32, i32 }>* @"module descriptor main", i32 0, i32 2) to i64)) to i32) }>, section "__TEXT,__const", align 4
@1 = private constant [4 x i8] c"Cat\00"
@"nominal type descriptor for main.Cat" = hidden constant <{ i32, i32, i32, i32, i32, i32, i32 }> <{ i32 81, i32 trunc (i64 sub (i64 ptrtoint (<{ i32, i32, i32 }>* @"module descriptor main" to i64), i64 ptrtoint (i32* getelementptr inbounds (<{ i32, i32, i32, i32, i32, i32, i32 }>, <{ i32, i32, i32, i32, i32, i32, i32 }>* @"nominal type descriptor for main.Cat", i32 0, i32 1) to i64)) to i32), i32 trunc (i64 sub (i64 ptrtoint ([4 x i8]* @1 to i64), i64 ptrtoint (i32* getelementptr inbounds (<{ i32, i32, i32, i32, i32, i32, i32 }>, <{ i32, i32, i32, i32, i32, i32, i32 }>* @"nominal type descriptor for main.Cat", i32 0, i32 2) to i64)) to i32), i32 trunc (i64 sub (i64 ptrtoint (%swift.metadata_response (i64)* @"type metadata accessor for main.Cat" to i64), i64 ptrtoint (i32* getelementptr inbounds (<{ i32, i32, i32, i32, i32, i32, i32 }>, <{ i32, i32, i32, i32, i32, i32, i32 }>* @"nominal type descriptor for main.Cat", i32 0, i32 3) to i64)) to i32), i32 trunc (i64 sub (i64 ptrtoint ({ i32, i32, i16, i16, i32, i32, i32, i32 }* @"reflection metadata field descriptor main.Cat" to i64), i64 ptrtoint (i32* getelementptr inbounds (<{ i32, i32, i32, i32, i32, i32, i32 }>, <{ i32, i32, i32, i32, i32, i32, i32 }>* @"nominal type descriptor for main.Cat", i32 0, i32 4) to i64)) to i32), i32 1, i32 2 }>, section "__TEXT,__const", align 4
@"full type metadata for main.Cat" = internal constant <{ i8**, i64, <{ i32, i32, i32, i32, i32, i32, i32 }>*, i32, [4 x i8] }> <{ i8** getelementptr inbounds (%swift.vwtable, %swift.vwtable* @"value witness table for main.Cat", i32 0, i32 0), i64 512, <{ i32, i32, i32, i32, i32, i32, i32 }>* @"nominal type descriptor for main.Cat", i32 0, [4 x i8] zeroinitializer }>, align 8
@"symbolic _____ 4main3CatV" = linkonce_odr hidden constant <{ i8, i32, i8 }> <{ i8 1, i32 trunc (i64 sub (i64 ptrtoint (<{ i32, i32, i32, i32, i32, i32, i32 }>* @"nominal type descriptor for main.Cat" to i64), i64 ptrtoint (i32* getelementptr inbounds (<{ i8, i32, i8 }>, <{ i8, i32, i8 }>* @"symbolic _____ 4main3CatV", i32 0, i32 1) to i64)) to i32), i8 0 }>, section "__TEXT,__swift5_typeref, regular, no_dead_strip", align 2
@"symbolic yyc" = linkonce_odr hidden constant <{ [3 x i8], i8 }> <{ [3 x i8] c"yyc", i8 0 }>, section "__TEXT,__swift5_typeref, regular, no_dead_strip", align 2
@2 = private constant [6 x i8] c"biBao\00", section "__TEXT,__swift5_reflstr, regular, no_dead_strip"
@"reflection metadata field descriptor main.Cat" = internal constant { i32, i32, i16, i16, i32, i32, i32, i32 } { i32 trunc (i64 sub (i64 ptrtoint (<{ i8, i32, i8 }>* @"symbolic _____ 4main3CatV" to i64), i64 ptrtoint ({ i32, i32, i16, i16, i32, i32, i32, i32 }* @"reflection metadata field descriptor main.Cat" to i64)) to i32), i32 0, i16 0, i16 12, i32 1, i32 2, i32 trunc (i64 sub (i64 ptrtoint (<{ [3 x i8], i8 }>* @"symbolic yyc" to i64), i64 ptrtoint (i32* getelementptr inbounds ({ i32, i32, i16, i16, i32, i32, i32, i32 }, { i32, i32, i16, i16, i32, i32, i32, i32 }* @"reflection metadata field descriptor main.Cat", i32 0, i32 6) to i64)) to i32), i32 trunc (i64 sub (i64 ptrtoint ([6 x i8]* @2 to i64), i64 ptrtoint (i32* getelementptr inbounds ({ i32, i32, i16, i16, i32, i32, i32, i32 }, { i32, i32, i16, i16, i32, i32, i32, i32 }* @"reflection metadata field descriptor main.Cat", i32 0, i32 7) to i64)) to i32) }, section "__TEXT,__swift5_fieldmd, regular, no_dead_strip", align 4
@"_swift_FORCE_LOAD_$_swiftFoundation_$_main" = weak_odr hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftFoundation"
@"_swift_FORCE_LOAD_$_swiftObjectiveC_$_main" = weak_odr hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftObjectiveC"
@"_swift_FORCE_LOAD_$_swiftDarwin_$_main" = weak_odr hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftDarwin"
@"_swift_FORCE_LOAD_$_swiftCoreFoundation_$_main" = weak_odr hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftCoreFoundation"
@"_swift_FORCE_LOAD_$_swiftDispatch_$_main" = weak_odr hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftDispatch"
@"_swift_FORCE_LOAD_$_swiftCoreGraphics_$_main" = weak_odr hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftCoreGraphics"
@"_swift_FORCE_LOAD_$_swiftIOKit_$_main" = weak_odr hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftIOKit"
@"_swift_FORCE_LOAD_$_swiftXPC_$_main" = weak_odr hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftXPC"
@"\01l_type_metadata_table" = private constant [1 x %swift.type_metadata_record] [%swift.type_metadata_record { i32 trunc (i64 sub (i64 ptrtoint (<{ i32, i32, i32, i32, i32, i32, i32 }>* @"nominal type descriptor for main.Cat" to i64), i64 ptrtoint ([1 x %swift.type_metadata_record]* @"\01l_type_metadata_table" to i64)) to i32) }], section "__TEXT, __swift5_types, regular, no_dead_strip", align 4
@__swift_reflection_version = linkonce_odr hidden constant i16 3
@llvm.used = appending global [13 x i8*] [i8* bitcast (i32 (i32, i8**)* @main to i8*), i8* bitcast ({ i32 }* @"\01l_entry_point" to i8*), i8* bitcast ({ i32, i32, i16, i16, i32, i32, i32, i32 }* @"reflection metadata field descriptor main.Cat" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftFoundation_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftObjectiveC_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftDarwin_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftCoreFoundation_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftDispatch_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftCoreGraphics_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftIOKit_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftXPC_$_main" to i8*), i8* bitcast ([1 x %swift.type_metadata_record]* @"\01l_type_metadata_table" to i8*), i8* bitcast (i16* @__swift_reflection_version to i8*)], section "llvm.metadata", align 8

@"type metadata for main.Cat" = hidden alias %swift.type, bitcast (i64* getelementptr inbounds (<{ i8**, i64, <{ i32, i32, i32, i32, i32, i32, i32 }>*, i32, [4 x i8] }>, <{ i8**, i64, <{ i32, i32, i32, i32, i32, i32, i32 }>*, i32, [4 x i8] }>* @"full type metadata for main.Cat", i32 0, i32 1) to %swift.type*)

define i32 @main(i32 %0, i8** %1) #0 {
entry:
  %2 = bitcast i8** %1 to i8*
  ret i32 0
}

define hidden swiftcc { i8*, %swift.refcounted* } @"main.Cat.biBao.getter : () -> ()"(i8* %0, %swift.refcounted* %1) #0 {
entry:
  %2 = call %swift.refcounted* @swift_retain(%swift.refcounted* returned %1) #1
  %3 = insertvalue { i8*, %swift.refcounted* } undef, i8* %0, 0
  %4 = insertvalue { i8*, %swift.refcounted* } %3, %swift.refcounted* %1, 1
  ret { i8*, %swift.refcounted* } %4
}

; Function Attrs: nounwind
declare %swift.refcounted* @swift_retain(%swift.refcounted* returned) #1

define hidden swiftcc void @"main.Cat.biBao.setter : () -> ()"(i8* %0, %swift.refcounted* %1, %T4main3CatV* nocapture swiftself dereferenceable(16) %2) #0 {
entry:
  %3 = call %swift.refcounted* @swift_retain(%swift.refcounted* returned %1) #1
  %.biBao = getelementptr inbounds %T4main3CatV, %T4main3CatV* %2, i32 0, i32 0
  %.biBao.fn = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 0
  %4 = load i8*, i8** %.biBao.fn, align 8
  %.biBao.data = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 1
  %5 = load %swift.refcounted*, %swift.refcounted** %.biBao.data, align 8
  %.biBao.fn1 = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 0
  store i8* %0, i8** %.biBao.fn1, align 8
  %.biBao.data2 = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 1
  store %swift.refcounted* %1, %swift.refcounted** %.biBao.data2, align 8
  call void @swift_release(%swift.refcounted* %5) #1
  call void @swift_release(%swift.refcounted* %1) #1
  ret void
}

; Function Attrs: nounwind
declare void @swift_release(%swift.refcounted*) #1

; Function Attrs: noinline
define hidden swiftcc { i8*, %swift.function* } @"main.Cat.biBao.modify : () -> ()"(i8* noalias dereferenceable(32) %0, %T4main3CatV* nocapture swiftself dereferenceable(16) %1) #2 {
entry:
  %.biBao = getelementptr inbounds %T4main3CatV, %T4main3CatV* %1, i32 0, i32 0
  %2 = insertvalue { i8*, %swift.function* } { i8* bitcast (void (i8*, i1)* @"main.Cat.biBao.modify : () -> () with unmangled suffix ".resume.0"" to i8*), %swift.function* undef }, %swift.function* %.biBao, 1
  ret { i8*, %swift.function* } %2
}

define internal swiftcc void @"main.Cat.biBao.modify : () -> () with unmangled suffix ".resume.0""(i8* noalias nonnull align 8 dereferenceable(32) %0, i1 %1) #0 {
entryresume.0:
  %FramePtr = bitcast i8* %0 to %"main.Cat.biBao.modify : () -> () with unmangled suffix ".Frame""*
  %vFrame = bitcast %"main.Cat.biBao.modify : () -> () with unmangled suffix ".Frame""* %FramePtr to i8*
  ret void
}

declare swiftcc void @"coroutine continuation prototype for @escaping @convention(thin) @convention(method) @yield_once (@inout main.Cat) -> (@yields @inout @escaping @callee_guaranteed () -> ())"(i8* noalias dereferenceable(32), i1) #0

declare i8* @malloc(i64)

declare void @free(i8*)

; Function Attrs: nounwind
declare token @llvm.coro.id.retcon.once(i32, i32, i8*, i8*, i8*, i8*) #1

; Function Attrs: nounwind
declare i8* @llvm.coro.begin(token, i8* writeonly) #1

; Function Attrs: nounwind
declare i1 @llvm.coro.suspend.retcon.i1(...) #1

; Function Attrs: nounwind
declare i1 @llvm.coro.end(i8*, i1) #1

define hidden swiftcc { i8*, %swift.refcounted* } @"main.Cat.init(biBao: () -> ()) -> main.Cat"(i8* %0, %swift.refcounted* %1) #0 {
entry:
  %2 = insertvalue { i8*, %swift.refcounted* } undef, i8* %0, 0
  %3 = insertvalue { i8*, %swift.refcounted* } %2, %swift.refcounted* %1, 1
  ret { i8*, %swift.refcounted* } %3
}

; Function Attrs: nounwind
define internal %swift.opaque* @"initializeBufferWithCopyOfBuffer value witness for main.Cat"([24 x i8]* noalias %dest, [24 x i8]* noalias %src, %swift.type* %Cat) #3 {
entry:
  %object = bitcast [24 x i8]* %dest to %T4main3CatV*
  %object1 = bitcast [24 x i8]* %src to %T4main3CatV*
  %object.biBao = getelementptr inbounds %T4main3CatV, %T4main3CatV* %object, i32 0, i32 0
  %object1.biBao = getelementptr inbounds %T4main3CatV, %T4main3CatV* %object1, i32 0, i32 0
  %object1.biBao.fn = getelementptr inbounds %swift.function, %swift.function* %object1.biBao, i32 0, i32 0
  %object1.biBao.fn.load = load i8*, i8** %object1.biBao.fn, align 8
  %object1.biBao.data = getelementptr inbounds %swift.function, %swift.function* %object1.biBao, i32 0, i32 1
  %0 = load %swift.refcounted*, %swift.refcounted** %object1.biBao.data, align 8
  %1 = call %swift.refcounted* @swift_retain(%swift.refcounted* returned %0) #1
  %object.biBao.fn = getelementptr inbounds %swift.function, %swift.function* %object.biBao, i32 0, i32 0
  store i8* %object1.biBao.fn.load, i8** %object.biBao.fn, align 8
  %object.biBao.data = getelementptr inbounds %swift.function, %swift.function* %object.biBao, i32 0, i32 1
  store %swift.refcounted* %0, %swift.refcounted** %object.biBao.data, align 8
  %2 = bitcast %T4main3CatV* %object to %swift.opaque*
  ret %swift.opaque* %2
}

; Function Attrs: nounwind
define internal void @"destroy value witness for main.Cat"(%swift.opaque* noalias %object, %swift.type* %Cat) #3 {
entry:
  %0 = bitcast %swift.opaque* %object to %T4main3CatV*
  %.biBao = getelementptr inbounds %T4main3CatV, %T4main3CatV* %0, i32 0, i32 0
  %.biBao.data = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 1
  %1 = load %swift.refcounted*, %swift.refcounted** %.biBao.data, align 8
  call void @swift_release(%swift.refcounted* %1) #1
  ret void
}

; Function Attrs: nounwind
define internal %swift.opaque* @"initializeWithCopy value witness for main.Cat"(%swift.opaque* noalias %dest, %swift.opaque* noalias %src, %swift.type* %Cat) #3 {
entry:
  %0 = bitcast %swift.opaque* %dest to %T4main3CatV*
  %1 = bitcast %swift.opaque* %src to %T4main3CatV*
  %.biBao = getelementptr inbounds %T4main3CatV, %T4main3CatV* %0, i32 0, i32 0
  %.biBao1 = getelementptr inbounds %T4main3CatV, %T4main3CatV* %1, i32 0, i32 0
  %.biBao1.fn = getelementptr inbounds %swift.function, %swift.function* %.biBao1, i32 0, i32 0
  %.biBao1.fn.load = load i8*, i8** %.biBao1.fn, align 8
  %.biBao1.data = getelementptr inbounds %swift.function, %swift.function* %.biBao1, i32 0, i32 1
  %2 = load %swift.refcounted*, %swift.refcounted** %.biBao1.data, align 8
  %3 = call %swift.refcounted* @swift_retain(%swift.refcounted* returned %2) #1
  %.biBao.fn = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 0
  store i8* %.biBao1.fn.load, i8** %.biBao.fn, align 8
  %.biBao.data = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 1
  store %swift.refcounted* %2, %swift.refcounted** %.biBao.data, align 8
  %4 = bitcast %T4main3CatV* %0 to %swift.opaque*
  ret %swift.opaque* %4
}

; Function Attrs: nounwind
define internal %swift.opaque* @"assignWithCopy value witness for main.Cat"(%swift.opaque* %dest, %swift.opaque* %src, %swift.type* %Cat) #3 {
entry:
  %0 = bitcast %swift.opaque* %dest to %T4main3CatV*
  %1 = bitcast %swift.opaque* %src to %T4main3CatV*
  %.biBao = getelementptr inbounds %T4main3CatV, %T4main3CatV* %0, i32 0, i32 0
  %.biBao1 = getelementptr inbounds %T4main3CatV, %T4main3CatV* %1, i32 0, i32 0
  %.biBao1.fn = getelementptr inbounds %swift.function, %swift.function* %.biBao1, i32 0, i32 0
  %.biBao1.fn.load = load i8*, i8** %.biBao1.fn, align 8
  %.biBao1.data = getelementptr inbounds %swift.function, %swift.function* %.biBao1, i32 0, i32 1
  %2 = load %swift.refcounted*, %swift.refcounted** %.biBao1.data, align 8
  %3 = call %swift.refcounted* @swift_retain(%swift.refcounted* returned %2) #1
  %.biBao.fn = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 0
  store i8* %.biBao1.fn.load, i8** %.biBao.fn, align 8
  %.biBao.data = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 1
  %4 = load %swift.refcounted*, %swift.refcounted** %.biBao.data, align 8
  store %swift.refcounted* %2, %swift.refcounted** %.biBao.data, align 8
  call void @swift_release(%swift.refcounted* %4) #1
  %5 = bitcast %T4main3CatV* %0 to %swift.opaque*
  ret %swift.opaque* %5
}

; Function Attrs: nounwind
define linkonce_odr hidden i8* @__swift_memcpy16_8(i8* %0, i8* %1, %swift.type* %2) #3 {
entry:
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 %1, i64 16, i1 false)
  ret i8* %0
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #4

; Function Attrs: nounwind
define internal %swift.opaque* @"assignWithTake value witness for main.Cat"(%swift.opaque* noalias %dest, %swift.opaque* noalias %src, %swift.type* %Cat) #3 {
entry:
  %0 = bitcast %swift.opaque* %dest to %T4main3CatV*
  %1 = bitcast %swift.opaque* %src to %T4main3CatV*
  %.biBao = getelementptr inbounds %T4main3CatV, %T4main3CatV* %0, i32 0, i32 0
  %.biBao1 = getelementptr inbounds %T4main3CatV, %T4main3CatV* %1, i32 0, i32 0
  %.biBao1.fn = getelementptr inbounds %swift.function, %swift.function* %.biBao1, i32 0, i32 0
  %2 = load i8*, i8** %.biBao1.fn, align 8
  %.biBao1.data = getelementptr inbounds %swift.function, %swift.function* %.biBao1, i32 0, i32 1
  %3 = load %swift.refcounted*, %swift.refcounted** %.biBao1.data, align 8
  %.biBao.fn = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 0
  store i8* %2, i8** %.biBao.fn, align 8
  %.biBao.data = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 1
  %4 = load %swift.refcounted*, %swift.refcounted** %.biBao.data, align 8
  store %swift.refcounted* %3, %swift.refcounted** %.biBao.data, align 8
  call void @swift_release(%swift.refcounted* %4) #1
  %5 = bitcast %T4main3CatV* %0 to %swift.opaque*
  ret %swift.opaque* %5
}

; Function Attrs: nounwind readonly
define internal i32 @"getEnumTagSinglePayload value witness for main.Cat"(%swift.opaque* noalias %value, i32 %numEmptyCases, %swift.type* %Cat) #5 {
entry:
  %0 = bitcast %swift.opaque* %value to %T4main3CatV*
  %1 = icmp eq i32 0, %numEmptyCases
  br i1 %1, label %41, label %2

2:                                                ; preds = %entry
  %3 = icmp ugt i32 %numEmptyCases, 2147483647
  br i1 %3, label %4, label %35

4:                                                ; preds = %2
  %5 = sub i32 %numEmptyCases, 2147483647
  %6 = bitcast %T4main3CatV* %0 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i32 16
  br i1 false, label %8, label %9

8:                                                ; preds = %4
  br label %23

9:                                                ; preds = %4
  br i1 true, label %10, label %13

10:                                               ; preds = %9
  %11 = load i8, i8* %7, align 1
  %12 = zext i8 %11 to i32
  br label %23

13:                                               ; preds = %9
  br i1 false, label %14, label %18

14:                                               ; preds = %13
  %15 = bitcast i8* %7 to i16*
  %16 = load i16, i16* %15, align 1
  %17 = zext i16 %16 to i32
  br label %23

18:                                               ; preds = %13
  br i1 false, label %19, label %22

19:                                               ; preds = %18
  %20 = bitcast i8* %7 to i32*
  %21 = load i32, i32* %20, align 1
  br label %23

22:                                               ; preds = %18
  unreachable

23:                                               ; preds = %19, %14, %10, %8
  %24 = phi i32 [ 0, %8 ], [ %12, %10 ], [ %17, %14 ], [ %21, %19 ]
  %25 = icmp eq i32 %24, 0
  br i1 %25, label %35, label %26

26:                                               ; preds = %23
  %27 = sub i32 %24, 1
  %28 = shl i32 %27, 128
  %29 = select i1 true, i32 0, i32 %28
  %30 = bitcast i8* %6 to i128*
  %31 = load i128, i128* %30, align 1
  %32 = trunc i128 %31 to i32
  %33 = or i32 %32, %29
  %34 = add i32 2147483647, %33
  br label %42

35:                                               ; preds = %23, %2
  %.biBao = getelementptr inbounds %T4main3CatV, %T4main3CatV* %0, i32 0, i32 0
  %.biBao.fn = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 0
  %36 = bitcast i8** %.biBao.fn to i64*
  %37 = load i64, i64* %36, align 8
  %38 = icmp uge i64 %37, 4294967296
  br i1 %38, label %is-valid-pointer, label %is-invalid-pointer

is-invalid-pointer:                               ; preds = %35
  %39 = trunc i64 %37 to i32
  br label %is-valid-pointer

is-valid-pointer:                                 ; preds = %is-invalid-pointer, %35
  %40 = phi i32 [ -1, %35 ], [ %39, %is-invalid-pointer ]
  br label %42

41:                                               ; preds = %entry
  br label %42

42:                                               ; preds = %41, %is-valid-pointer, %26
  %43 = phi i32 [ %40, %is-valid-pointer ], [ %34, %26 ], [ -1, %41 ]
  %44 = add i32 %43, 1
  ret i32 %44
}

; Function Attrs: nounwind
define internal void @"storeEnumTagSinglePayload value witness for main.Cat"(%swift.opaque* noalias %value, i32 %whichCase, i32 %numEmptyCases, %swift.type* %Cat) #3 {
entry:
  %0 = bitcast %swift.opaque* %value to %T4main3CatV*
  %1 = bitcast %T4main3CatV* %0 to i8*
  %2 = getelementptr inbounds i8, i8* %1, i32 16
  %3 = icmp ugt i32 %numEmptyCases, 2147483647
  br i1 %3, label %4, label %6

4:                                                ; preds = %entry
  %5 = sub i32 %numEmptyCases, 2147483647
  br label %6

6:                                                ; preds = %4, %entry
  %7 = phi i32 [ 0, %entry ], [ 1, %4 ]
  %8 = icmp ule i32 %whichCase, 2147483647
  br i1 %8, label %9, label %30

9:                                                ; preds = %6
  %10 = icmp eq i32 %7, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %9
  br label %24

12:                                               ; preds = %9
  %13 = icmp eq i32 %7, 1
  br i1 %13, label %14, label %15

14:                                               ; preds = %12
  store i8 0, i8* %2, align 8
  br label %24

15:                                               ; preds = %12
  %16 = icmp eq i32 %7, 2
  br i1 %16, label %17, label %19

17:                                               ; preds = %15
  %18 = bitcast i8* %2 to i16*
  store i16 0, i16* %18, align 8
  br label %24

19:                                               ; preds = %15
  %20 = icmp eq i32 %7, 4
  br i1 %20, label %21, label %23

21:                                               ; preds = %19
  %22 = bitcast i8* %2 to i32*
  store i32 0, i32* %22, align 8
  br label %24

23:                                               ; preds = %19
  unreachable

24:                                               ; preds = %21, %17, %14, %11
  %25 = icmp eq i32 %whichCase, 0
  br i1 %25, label %59, label %26

26:                                               ; preds = %24
  %27 = sub i32 %whichCase, 1
  %.biBao = getelementptr inbounds %T4main3CatV, %T4main3CatV* %0, i32 0, i32 0
  %.biBao.fn = getelementptr inbounds %swift.function, %swift.function* %.biBao, i32 0, i32 0
  %28 = zext i32 %27 to i64
  %29 = bitcast i8** %.biBao.fn to i64*
  store i64 %28, i64* %29, align 8
  br label %59

30:                                               ; preds = %6
  %31 = sub i32 %whichCase, 1
  %32 = sub i32 %31, 2147483647
  br i1 true, label %37, label %33

33:                                               ; preds = %30
  %34 = lshr i32 %32, 128
  %35 = add i32 1, %34
  %36 = and i32 undef, %32
  br label %37

37:                                               ; preds = %33, %30
  %38 = phi i32 [ 1, %30 ], [ %35, %33 ]
  %39 = phi i32 [ %32, %30 ], [ %36, %33 ]
  %40 = zext i32 %39 to i128
  %41 = bitcast i8* %1 to i128*
  store i128 %40, i128* %41, align 8
  %42 = icmp eq i32 %7, 0
  br i1 %42, label %43, label %44

43:                                               ; preds = %37
  br label %58

44:                                               ; preds = %37
  %45 = icmp eq i32 %7, 1
  br i1 %45, label %46, label %48

46:                                               ; preds = %44
  %47 = trunc i32 %38 to i8
  store i8 %47, i8* %2, align 8
  br label %58

48:                                               ; preds = %44
  %49 = icmp eq i32 %7, 2
  br i1 %49, label %50, label %53

50:                                               ; preds = %48
  %51 = trunc i32 %38 to i16
  %52 = bitcast i8* %2 to i16*
  store i16 %51, i16* %52, align 8
  br label %58

53:                                               ; preds = %48
  %54 = icmp eq i32 %7, 4
  br i1 %54, label %55, label %57

55:                                               ; preds = %53
  %56 = bitcast i8* %2 to i32*
  store i32 %38, i32* %56, align 8
  br label %58

57:                                               ; preds = %53
  unreachable

58:                                               ; preds = %55, %50, %46, %43
  br label %59

59:                                               ; preds = %58, %26, %24
  ret void
}

; Function Attrs: noinline nounwind readnone
define hidden swiftcc %swift.metadata_response @"type metadata accessor for main.Cat"(i64 %0) #6 {
entry:
  ret %swift.metadata_response { %swift.type* bitcast (i64* getelementptr inbounds (<{ i8**, i64, <{ i32, i32, i32, i32, i32, i32, i32 }>*, i32, [4 x i8] }>, <{ i8**, i64, <{ i32, i32, i32, i32, i32, i32, i32 }>*, i32, [4 x i8] }>* @"full type metadata for main.Cat", i32 0, i32 1) to %swift.type*), i64 0 }
}

declare extern_weak void @"_swift_FORCE_LOAD_$_swiftFoundation"()

declare extern_weak void @"_swift_FORCE_LOAD_$_swiftObjectiveC"()

declare extern_weak void @"_swift_FORCE_LOAD_$_swiftDarwin"()

declare extern_weak void @"_swift_FORCE_LOAD_$_swiftCoreFoundation"()

declare extern_weak void @"_swift_FORCE_LOAD_$_swiftDispatch"()

declare extern_weak void @"_swift_FORCE_LOAD_$_swiftCoreGraphics"()

declare extern_weak void @"_swift_FORCE_LOAD_$_swiftIOKit"()

declare extern_weak void @"_swift_FORCE_LOAD_$_swiftXPC"()

; Function Attrs: alwaysinline
define private void @coro.devirt.trigger(i8* %0) #7 {
entry:
  ret void
}

attributes #0 = { "correctly-rounded-divide-sqrt-fp-math"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { noinline "correctly-rounded-divide-sqrt-fp-math"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind willreturn }
attributes #5 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noinline nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { alwaysinline }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!swift.module.flags = !{!9}
!llvm.asan.globals = !{!10, !11, !12, !13, !14, !15, !16, !17}
!llvm.linker.options = !{!18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 11, i32 3]}
!1 = !{i32 1, !"Objective-C Version", i32 2}
!2 = !{i32 1, !"Objective-C Image Info Version", i32 0}
!3 = !{i32 1, !"Objective-C Image Info Section", !"__DATA,__objc_imageinfo,regular,no_dead_strip"}
!4 = !{i32 4, !"Objective-C Garbage Collection", i32 84150016}
!5 = !{i32 1, !"Objective-C Class Properties", i32 64}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = !{i32 7, !"PIC Level", i32 2}
!8 = !{i32 1, !"Swift Version", i32 7}
!9 = !{!"standard-library", i1 false}
!10 = !{<{ i32, i32, i32 }>* @"module descriptor main", null, null, i1 false, i1 true}
!11 = !{<{ i32, i32, i32, i32, i32, i32, i32 }>* @"nominal type descriptor for main.Cat", null, null, i1 false, i1 true}
!12 = !{<{ i8, i32, i8 }>* @"symbolic _____ 4main3CatV", null, null, i1 false, i1 true}
!13 = !{<{ [3 x i8], i8 }>* @"symbolic yyc", null, null, i1 false, i1 true}
!14 = !{[6 x i8]* @2, null, null, i1 false, i1 true}
!15 = !{{ i32, i32, i16, i16, i32, i32, i32, i32 }* @"reflection metadata field descriptor main.Cat", null, null, i1 false, i1 true}
!16 = !{[1 x %swift.type_metadata_record]* @"\01l_type_metadata_table", null, null, i1 false, i1 true}
!17 = !{[13 x i8*]* @llvm.used, null, null, i1 false, i1 true}
!18 = !{!"-lswiftFoundation"}
!19 = !{!"-lswiftCore"}
!20 = !{!"-lswiftObjectiveC"}
!21 = !{!"-lswiftDarwin"}
!22 = !{!"-framework", !"Foundation"}
!23 = !{!"-lswiftCoreFoundation"}
!24 = !{!"-framework", !"CoreFoundation"}
!25 = !{!"-lswiftDispatch"}
!26 = !{!"-framework", !"Combine"}
!27 = !{!"-framework", !"ApplicationServices"}
!28 = !{!"-lswiftCoreGraphics"}
!29 = !{!"-framework", !"CoreGraphics"}
!30 = !{!"-lswiftIOKit"}
!31 = !{!"-framework", !"IOKit"}
!32 = !{!"-framework", !"ColorSync"}
!33 = !{!"-framework", !"ImageIO"}
!34 = !{!"-framework", !"CoreServices"}
!35 = !{!"-framework", !"Security"}
!36 = !{!"-lswiftXPC"}
!37 = !{!"-framework", !"CFNetwork"}
!38 = !{!"-framework", !"DiskArbitration"}
!39 = !{!"-framework", !"CoreText"}
!40 = !{!"-lswiftSwiftOnoneSupport"}
!41 = !{!"-lobjc"}
