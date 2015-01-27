Assume you have tree-like structure as below:
...
<a>
	<k>k</k>
	<l>l</l>
	<m>m</m>
	<b>
		<c>c1</c>
		<c>c2</c>
		<q>q</q>
		<r>r</r>
	</b>
	<b>
		<c>c3</c>
		<c>c4</c>
		<q>q</q>
	</b>
<a>
...
Output wanted in resulting csv table is somewhat like:
k;l;m;c1;q;r;c3;q;
k;l;m;c1;q;r;c4;q;
k;l;m;c2;q;r;c3;q;
k;l;m;c2;q;r;c4;q;
Plain text then has to be converted into an old DBF file format with MS Visual Fox Pro small program.
There are plenty of XML Editors can be found for exporting XQuery result as simple text. 
Purpose of this project is to mimic such XQuery for every similarly named nodes across xml documents of same structure and different content.
As you can see all the nodes that have equal nodename are repeatedly appear in each line one by one.
This produces output that correctly reflects tree structure in resulting csv table (for operations like 'sum over one column').
The algorithm also produces header for such csv table, collecting nodenames all over the input file. 
For the ongoing DBF convertion, all the column names are truncated to 10 chars limit and all duplicate column names are eliminated (truncated and enumerated).
This script bundle has been created for those who is not able or does not want to learn XQuery, XSLT, XPath and the company on my recent job.
Though, it seems too slow running to convert very big xml files (as for now, over 7000 xml nodes would take about 35 minutes to convert, this will produce over 35000 lines (4-6 same nodenames per a direct child of root) for the resulting DBF file)
