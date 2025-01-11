package Infraops.Project.Repositories;

import Infraops.Project.Models.Book;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface BookRepository extends MongoRepository<Book, String> {
    // Custom query methods (if needed)
    List<Book> findByTitle(String title);
}
