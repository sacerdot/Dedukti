
open Types

type gst = private
  | Decl  of term * (int*gdt) option 
  | Def   of term * term

val init                : ident -> unit

val import              : loc -> ident -> unit 

val export_and_clear    : unit -> unit

val get_global_symbol   : loc -> ident -> ident -> gst

val get_global_type     : loc -> ident -> ident -> term

val get_global_rw       : loc -> ident -> ident -> (int*gdt) option

val add_decl            : loc -> ident -> term -> unit

val add_def             : loc -> ident -> term -> term -> unit

val add_rw              : loc -> ident -> (int*gdt) -> unit