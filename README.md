# ValueRow

A commonly used view for SwiftUI's `List` and `Form`. The view contains an image, a leading label, and a trailing value.

## Highlight Features

- Supports multiline text: Label and Value.
- Supports individual font: Image, Label, and Value.
- Supports tap or long press action: Image, Label, and Value.


## Sample Code

``` Swift
import ValueRow

struct CheckoutView: View {
    
    var body: some View {
        Form {
            Section("ITEM") {
                ValueRow("Name", value: "Ice Cream")
                    .withValue(lineLimit: 2)
                
                ValueRow("Price", value: "$4.00")
                    .withValue(font: .body.monospacedDigit())
                
                ValueRow("Quantity", value: "3")
                    .withValue(font: .body.monospacedDigit())
            }
            Section("TOTAL") {
                ValueRow("Subtotal", symbol: "plus.circle", value: "$12.00")
                    .withValue(font: .body.monospacedDigit())
                
                ValueRow("Discount", symbol: "minus.circle", value: "$3.00")
                    .withValue(font: .body.monospacedDigit())
                
                ValueRow("Total", symbol: "equal.circle", value: "$9.00")
                    .withLabel(font: .title3.weight(.bold))
                    .withValue(font: .title3.monospacedDigit().weight(.bold))
            }
        }
    }
}
```
