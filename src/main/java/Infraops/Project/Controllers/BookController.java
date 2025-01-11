package Infraops.Project.Controllers;


import Infraops.Project.Models.Book;
import Infraops.Project.Service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@RestController
@RequestMapping("/books")
public class BookController {

    @Autowired
    private BookService bookService;

    @GetMapping
    public List<Book> getAllBooks() {
        return bookService.getAllBooks();
    }

    @PostMapping
    public Book addBook(@RequestBody Book book) {

        System.out.println(book.getAuthor());
        return bookService.saveBook(book);
    }
}
