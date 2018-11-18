module Data.Message exposing (Attachment, Message, attachmentDecoder, decoder)

import Data.Date exposing (date)
import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Time exposing (Posix)


type alias Message =
    { mailbox : String
    , id : String
    , from : String
    , to : List String
    , subject : String
    , date : Posix
    , size : Int
    , seen : Bool
    , text : String
    , html : String
    , attachments : List Attachment
    }


type alias Attachment =
    { id : String
    , fileName : String
    , contentType : String
    }


decoder : Decoder Message
decoder =
    succeed Message
        |> required "mailbox" string
        |> required "id" string
        |> optional "from" string ""
        |> required "to" (list string)
        |> optional "subject" string ""
        |> required "posix-millis" date
        |> required "size" int
        |> required "seen" bool
        |> required "text" string
        |> required "html" string
        |> required "attachments" (list attachmentDecoder)


attachmentDecoder : Decoder Attachment
attachmentDecoder =
    succeed Attachment
        |> required "id" string
        |> required "filename" string
        |> required "content-type" string
