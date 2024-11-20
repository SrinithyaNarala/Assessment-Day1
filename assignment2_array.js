//Assignment2
// Create array of Object of students which has Student
// id,name, result,percentage
 
// You should list out all passed student and they got the percentage greater than 80

const students = [
    { id: 1, name: "Rahul", result: "Pass", percentage: 85 },
    { id: 2, name: "Anjali", result: "Fail", percentage: 45 },
    { id: 3, name: "Priya", result: "Pass", percentage: 92 },
    { id: 4, name: "Rohan", result: "Pass", percentage: 78 },
    { id: 5, name: "Sneha", result: "Pass", percentage: 88 },
];

const passedStudents = students.filter(student => student.result === "Pass" && student.percentage > 80);
console.log("Students who passed with percentage > 80:");
passedStudents.forEach(student => {
    console.log(`ID: ${student.id}, Name: ${student.name}, Percentage: ${student.percentage}`);
});
