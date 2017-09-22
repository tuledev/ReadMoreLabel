
Read More UILabel
====================

An `UILabel` with a read more hyperlink text at the end of text.

![](https://github.com/anhtukhtn/ReadMoreLabel/blob/master/demo.png)

## Usage

Using as a normal UILabel

``` Objective-C

/// setup truncation token and num of lines

[lbContent setTruncationToken:@"... Read More"];
lbContent.text = @"A wiki is run using wiki software, otherwise known as a wiki engine. A wiki engine is a type of content management system, but it differs from most other such systems, including blog software, in that the content is created without any defined owner or leader, and wikis have little implicit structure, allowing structure to emerge according to the needs of the users.";
lbContent.numberOfLines = 3;

/// update layout and display truncation token

[lbContent updateLayout];

/// listen tap on truncation token event

[lbContent listenTappedOnTruncationToken:^{
  // do something
}];

```

## License

Available under the MIT license

