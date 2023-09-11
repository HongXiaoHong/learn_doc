# java 高级

## 字节码

### ASM | 通过适配器读取生成字节码[文件]

https://blog.csdn.net/zhuoxiuwu/article/details/78619645

改写构造方法

```java
class ChangeToChildConstructorMethodAdapter extends MethodAdapter { 
    private String superClassName; 
 
    public ChangeToChildConstructorMethodAdapter(MethodVisitor mv, 
        String superClassName) { 
        super(mv); 
        this.superClassName = superClassName; 
    } 
 
    public void visitMethodInsn(int opcode, String owner, String name, 
        String desc) { 
        // 调用父类的构造函数时
        if (opcode == Opcodes.INVOKESPECIAL && name.equals("<init>")) { 
            owner = superClassName; 
        } 
        super.visitMethodInsn(opcode, owner, name, desc);// 改写父类为 superClassName 
    } 
}

```

## 注解
### @Inherit | 子类继承父类的注解
限制: 子类的方法无法直接拿到 父类的 注解
但是可以使用 spring 的工具类拿到 
JAVA中的注解可以继承吗？
https://developer.aliyun.com/article/1115828

### 组合注解
https://segmentfault.com/a/1190000021223108

例如 spring 中的 Controller 注解 就跟 Component 一样
只是换了个名字而已
或者我可以理解为 java 中的注解可以进行 多继承

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Component
public @interface Controller {

	/**
	 * The value may indicate a suggestion for a logical component name,
	 * to be turned into a Spring bean in case of an autodetected component.
	 * @return the suggested component name, if any (or empty String otherwise)
	 */
	@AliasFor(annotation = Component.class)
	String value() default "";

}
```