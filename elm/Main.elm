
import Html.App
import App.Banking as Banking

main : Program Never
main =
  Html.App.program
    { init = Banking.init
    , view = Banking.view
    , update = Banking.update
    , subscriptions = Banking.subscriptions
    }
