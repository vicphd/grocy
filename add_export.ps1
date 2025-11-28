$jsFile = "public/viewjs/shoppinglist.js"
$exportFunction = @'

$("#export-shopping-list-button").on("click", function(e)
{
	e.preventDefault();

	var csvContent = "Product,Amount,Unit,Note,Product Group\r\n";

	shoppingListTable.rows({ search: 'applied' }).every(function(rowIdx, tableLoop, rowLoop)
	{
		var row = this.node();
		var cells = $(row).find('td');
		
		// Column 1: Product name + Note (note is in <em> tags)
		var productCell = $(cells[1]);
		var productText = productCell.clone();
		productText.find('br').replaceWith(' ');
		var fullText = productText.text().trim();
		var note = productCell.find('em').text().trim();
		var product = fullText.replace(note, '').trim();
		
		// Column 2: Amount + Unit
		var amountCell = $(cells[2]);
		var amount = amountCell.find('.locale-number-quantity-amount').text().trim();
		var unit = amountCell.text().trim().replace(amount, '').trim();
		
		// Column 3: Product Group
		var productGroup = $(cells[3]).text().trim();

		// Handle commas and quotes in content
		product = '"' + product.replace(/"/g, '""') + '"';
		note = '"' + note.replace(/"/g, '""') + '"';
		productGroup = '"' + productGroup.replace(/"/g, '""') + '"';

		csvContent += product + "," + amount + "," + unit + "," + note + "," + productGroup + "\r\n";
	});

	var blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
	var link = document.createElement("a");
	var url = URL.createObjectURL(blob);
	link.setAttribute("href", url);
	var fileName = "shopping_list_export_" + moment().format("YYYY-MM-DD_HH-mm-ss") + ".csv";
	link.setAttribute("download", fileName);
	link.style.visibility = 'hidden';
	document.body.appendChild(link);
	link.click();
	document.body.removeChild(link);
});
'@

Add-Content -Path $jsFile -Value $exportFunction
Write-Host "Export function added successfully"
